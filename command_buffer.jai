#scope_export

gpu_start_command_recording :: (queue_handle: Gpu_Queue) -> Gpu_Command_Buffer {
    // #TODO: should we do this on every command recording? uncertain.
    // currently this is the only thing that happens in collect garbage.
    // That will likely change so this will be less of a win but right
    // now it eliminates the need for collecting garbage.
    // It would also be much more efficient to bulk all the deletions at the same time
    // rather than querying the timeline semaphores and comparing on every command recorder.
    // How often are commands really recorded per frame? Not much, I doubt that overhead is significant.
    reclaim_completed_command_pools();

    // #todo: factor out
    queue := get_queue(queue_handle);

    family_index := queue.type;

    arena := *cmd_pools[family_index];

    if arena.available_pools.count == 0 {
        assert(arena.all_pools.count < MAX_COMMAND_POOLS);

        new_pool: VkCommandPool;

        create_info := VkCommandPoolCreateInfo.{
            flags = .TRANSIENT_BIT,
            queueFamilyIndex = queue.vk_family,
        };

        vk_result := vkCreateCommandPool(vk_device, *create_info, null, *new_pool);
        assert_vk_result(vk_result);
        
        new_buffer: VkCommandBuffer;

        alloc_info := VkCommandBufferAllocateInfo.{
            commandPool = new_pool,
            level = .PRIMARY,
            commandBufferCount = 1,
        };

        vk_result = vkAllocateCommandBuffers(vk_device, *alloc_info, *new_buffer);
        assert_vk_result(vk_result);

        _, pool := bucket_array_add(*arena.all_pools, .{
            vk_cmd_pool = new_pool,
            vk_cmd_buff = new_buffer,
        });
        array_add(*arena.available_pools, pool);
    }

    pool := pop(*arena.available_pools);
    assert(pool != null);

    // find an empty slot in the live pools list
    found, index := array_find(live_pools, null);
    // the list is preallocated to the maximum number of possible live command lists so this should never fail.
    assert(found);

    live_pools[index] = pool;

    cmd_buff_handle := cast(Gpu_Command_Buffer) (index + 1);

    begin_info := VkCommandBufferBeginInfo.{
        flags = .ONE_TIME_SUBMIT_BIT
    };
    vkBeginCommandBuffer(pool.vk_cmd_buff, *begin_info);

    return cmd_buff_handle;
}

gpu_submit :: (queue_handle: Gpu_Queue, buffer: Gpu_Command_Buffer) {
    assert(buffer != 0);
    index := (buffer - 1);
    assert(index < live_pools.count);
    pool := live_pools[index];

    vkEndCommandBuffer(pool.vk_cmd_buff);

    queue := get_queue(queue_handle);

    queue_timeline_value := atomic_add(*queue.timeline_value, 1) + 1; // atomic_add returns the previous value.

    signal_values := u64.[queue_timeline_value];
    signal_semaphores := VkSemaphore.[queue.timeline];

    timeline_info := VkTimelineSemaphoreSubmitInfo.{
        signalSemaphoreValueCount = signal_values.count.(u32),
        pSignalSemaphoreValues = signal_values.data,
    };

    cmd_buffers := VkCommandBuffer.[pool.vk_cmd_buff];
    submit_info := VkSubmitInfo.{
        pNext = *timeline_info,
        commandBufferCount = cmd_buffers.count.(u32),
        pCommandBuffers = cmd_buffers.data,
        signalSemaphoreCount = signal_semaphores.count.(u32),
        pSignalSemaphores = signal_semaphores.data,
    };
    vkQueueSubmit(queue.vk_queue, 1, *submit_info, VK_NULL_HANDLE);

    live_pools[index] = null;
    array_add(*garbage_pools[queue.type], .{queue_timeline_value, pool});
}

#scope_module

MAX_COMMAND_POOLS :: 128;

Command_Pool :: struct {
    vk_cmd_pool: VkCommandPool;
    vk_cmd_buff: VkCommandBuffer;
}

Command_Pool_Arena :: struct {
    all_pools: Bucket_Array(Command_Pool, 32);
    available_pools: [..] *Command_Pool;
}

cmd_pools: [NUM_QUEUE_FAMILIES] Command_Pool_Arena;

Garbage_Command_Pool :: struct {
    submit_timeline_value: u64;
    pool: *Command_Pool;
}

live_pools: [MAX_COMMAND_POOLS * NUM_QUEUE_FAMILIES] *Command_Pool;
// #TODO: fixed size allocation but can resizeable count within that buffer.
garbage_pools: [NUM_QUEUE_FAMILIES] [..] Garbage_Command_Pool;

reclaim_completed_command_pools :: () {
    for * arena, queue_index : cmd_pools {
        queue := *queues[queue_index];
        current_timeline_value: u64;
        vk_result := vkGetSemaphoreCounterValue(vk_device, queue.timeline, *current_timeline_value);
        assert_vk_result(vk_result);

        for garbage_pools[queue_index] {
            if it.submit_timeline_value <= current_timeline_value {
                vk_result = vkResetCommandPool(vk_device, it.pool.vk_cmd_pool, 0);
                assert_vk_result(vk_result);
                
                array_add(*arena.available_pools, it.pool);
                remove it;
            }
        }
    }
}
