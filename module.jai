Gpu_Pipeline :: #type,distinct u64;

Gpu_Texture :: #type,distinct u64;

Gpu_Depth_Stencil_State :: #type,distinct u64;

Gpu_Blend_State :: #type,distinct u64;

Gpu_Queue :: #type,distinct u64;

Gpu_Command_Buffer :: #type,distinct u64;

Gpu_Semaphore :: #type,distinct u64;

Gpu_Ptr :: #type,distinct u64;

Memory :: enum {
    DEFAULT;
    GPU;
    READBACK;
}

Cull :: enum {
    NONE;
    CCW;
    CW;
    ALL;
}

Depth_Flags :: enum_flags u8 {
    NONE    :: 0;
    READ    :: 1 << 0;
    WRITE   :: 1 << 1;
}

Op :: enum {
    NEVER;
    LESS;
    EQUAL;
    LESS_EQUAL;
    GREATER;
    NOT_EQUAL;
    GREATER_EQUAL;
    ALWAYS;
}

Stencil_Op :: enum {
    KEEP;
    ZERO;
    REPLACE;
    INVERT;
    INCREMENT_AND_CLAMP;
    DECREMENT_AND_CLAMP;
    INCREMENT_AND_WRAP;
    DECREMENT_AND_WARP;
}

Blend :: enum {
    ADD;
    SUBTRACT;
    REV_SUBTRACT;
    MIN;
    MAX;
}

Factor :: enum {
    ZERO;
    ONE;
    SRC_COLOR;
    DST_COLOR;
    SRC_ALPHA;
    DST_ALPHA;
    // #todo
}

Topology :: enum {
    TRIANGLE_LIST;
    TRIANGLE_STRIP;
    TRIANGLE_FAN;
}

Texture :: enum {
    _1D;
    _2D;
    _3D;
    CUBE;
    _2D_ARRAY;
    CUBE_ARRAY;
}

Format :: enum {
    NONE;
    // #todo
}

Usage_Flags :: enum {
    SAMPLED;
    STORAGE;
    COLOR_ATTACHMENT;
    DEPTH_STENCIL_ATTACHMENT;
    // #todo
}

Stage :: enum {
    TRANSFER;
    COMPUTE;
    RASTER_COLOR_OUT;
    PIXEL_SHADER;
    VERTEX_SHADER;
    // #todo:
}

Hazard_Flags :: enum {
    // #todo:
}

Signal :: enum {
    ATOMIC_SET;
    ATOMIC_MAX;
    ATOMIC_OR;
}

Gpu_Queue_Type :: enum {
    MAIN;
    COMPUTE;
    TRANSFER;
}

Stencil_Desc :: struct {
    test: Op = .ALWAYS;
    fail_op: Stencil_Op = .KEEP;
    pass_op: Stencil_Op = .KEEP;
    depth_fail_op: Stencil_Op = .KEEP;
    reference: u8 = 0;
}

Gpu_Depth_Stencil_Desc :: struct {
    depth_mode: Depth_Flags;
    depth_test: Op = .ALWAYS;

    depth_bias: float = 0.;
    depth_bias_slope_factor: float = 0.;
    depth_bias_clamp: float = 0.;

    stencil_read_mask: u8 = 0xff;
    stencil_write_mask: u8 = 0xff;

    stencil_front: Stencil_Desc;
    stencil_back: Stencil_Desc;
}

Color_Target :: struct {
    format: Format = .NONE;
    write_mask: u8 = 0xf;
}

Gpu_Raster_Desc :: struct {
    topology: Topology = .TRIANGLE_LIST;
    cull: Cull = .NONE;
    alpha_to_coverage := false;
    support_dual_source_blending := false;
    sample_count: u8 = 1;

    depth_format: Format = .NONE;
    stencil_format: Format = .NONE;
    
    color_targets: [] Color_Target;

    // #TODO: better way to convey Optional here.
    blend_state: *Gpu_Blend_State;
}

Gpu_Texture_Desc :: struct {
    type: Texture = ._2D;
    dimensions: [3] u32;

    mip_count: u32 = 1;
    layer_count: u32 = 1;
    sample_count: u32 = 1;

    format: Format = .NONE;
}

Gpu_View_Desc :: struct {
    format: Format = .NONE;
    base_mip: u8 = 0;
    mip_count: u8 = 0xFF; 
    base_layer: u16 = 0;
    layer_count: u16 = 0xFFFF;
}

Gpu_Render_Pass_Attachment_Desc :: struct {
    texture: Gpu_Texture;
    load_op: Op;
    store_op: Op;
    union {
        clear_value: float;
        clear_color: [3] u8;
    };
}

Gpu_Render_Pass_Desc :: struct {
    depth_target: Gpu_Render_Pass_Attachment_Desc;
    stencil_target: Gpu_Render_Pass_Attachment_Desc;
    color_targets: [] Gpu_Render_Pass_Attachment_Desc;
}

Memory_Layout :: struct {
    size: s64;
    align: s64;
}

// ----------------------------- Global ------------------------------------

gpu_init :: () {
    create_instance();
    create_device();
}

gpu_shutdown :: () {
    vmaDestroyAllocator(vma);
    vkDestroyDevice(vk_device, null);
    vkDestroyInstance(vk_instance, null);
}

// ----------------------------- Memory ------------------------------------

// #todo: use similar convetions to jai allocators?
gpu_malloc :: (size: s64, align: s64 = 0, memory_type: Memory = .DEFAULT) -> *void {
    return null;
}

gpu_free :: (ptr: *void) {
}

gpu_host_to_device_ptr :: (host: *void) -> Gpu_Ptr {
    return 0;
}


// ----------------------------- Textures ------------------------------------

gpu_compute_texture_layout :: (desc: Gpu_Texture_Desc) -> Memory_Layout {
    return .{};
}

gpu_create_texture :: (desc: Gpu_Texture_Desc, gpu_ptr: *void) -> Gpu_Texture {
    return 0;
}

gpu_texture_view :: (texture: Gpu_Texture, desc: Gpu_View_Desc) -> Gpu_Texture {
    return 0;
}

gpu_rw_texture_view :: (texture: Gpu_Texture, desc: Gpu_View_Desc) -> Gpu_Texture {
    return 0;
}


// ----------------------------- Pipelines ------------------------------------

gpu_create_compute_pipeline :: (spirv: [] u8) -> Gpu_Pipeline {
    return 0;
}

gpu_create_graphics_pipeline :: (vertex_spirv: [] u8, pixel_spirv: [] u8, raster_desc: Gpu_Raster_Desc) -> Gpu_Pipeline {
    return 0;
}

gpu_free_pipeline :: (pipeline: Gpu_Pipeline) {

}

// ----------------------------- Queues ------------------------------------

gpu_get_queue :: (queue_type: Gpu_Queue_Type, queue_index: u32) -> Gpu_Queue {
    return 0;
}

gpu_start_command_recording :: (queue: Gpu_Queue) -> Gpu_Command_Buffer {
    return 0;
}

gpu_submit :: (queue: Gpu_Queue, buffers: [] Gpu_Command_Buffer) {

}

// ----------------------------- Semaphores ------------------------------------

gpu_create_semaphore :: (initial: u64) -> Gpu_Semaphore {
    return 0;
}

gpu_wait_semaphore :: (semaphore: Gpu_Semaphore, value: u64) {

}

gpu_destroy_semaphore :: (semaphore: Gpu_Semaphore) {

}

// ----------------------------- Commands ------------------------------------

gpu_memcpy :: (cmd: Gpu_Command_Buffer, dest: Gpu_Ptr, src: Gpu_Ptr) {

}

gpu_copy_to_texture :: (cmd: Gpu_Command_Buffer, dest: Gpu_Ptr, src: Gpu_Ptr, texture: Gpu_Texture) {

}

gpu_copy_from_texture :: (cmd: Gpu_Command_Buffer, dest: Gpu_Ptr, src: Gpu_Ptr, texture: Gpu_Texture) {

}


gpu_barrier :: (cmd: Gpu_Command_Buffer, before: Stage, after: Stage) {

}

gpu_signal_after :: (cmd: Gpu_Command_Buffer, before: Stage, ptr: Gpu_Ptr, value: u64, signal: Signal) {
    
}

gpu_wait_before :: (cmd: Gpu_Command_Buffer, after: Stage, ptr: Gpu_Ptr, value: u64, op: Op, signal: Signal) {
    
}


gpu_set_pipeline :: (cmd: Gpu_Command_Buffer, pipeline: Gpu_Pipeline) {

}

gpu_set_depth_stencil_state :: (cmd: Gpu_Command_Buffer, state: Gpu_Depth_Stencil_State) {

}

gpu_set_blend_state :: (cmd: Gpu_Command_Buffer, state: Gpu_Blend_State) {

}

gpu_dispatch :: (cmd: Gpu_Command_Buffer, dimensions: [3] u32) {

}

gpu_indirect_dispatch :: (cmd: Gpu_Command_Buffer, dimensions_gpu: Gpu_Ptr) {

}

gpu_begin_render_pass :: (cmd: Gpu_Command_Buffer, desc: Gpu_Render_Pass_Desc) {

}

gpu_end_render_pass :: (cmd: Gpu_Command_Buffer) {

}

gpu_draw_indexed_instanced :: (cmd: Gpu_Command_Buffer, vertex_data: Gpu_Ptr, index_data: Gpu_Ptr, index_count: u32, instance_count: u32) {

}

#scope_module

assert_vk_result :: (result: VkResult) {
    assert(result == VkResult.SUCCESS);
}

create_instance :: () {
    auto_release_temp();
    push_allocator(temp);

    result: VkResult;

    optional_extensions: [..] string;
    array_add(*optional_extensions, VK_KHR_SURFACE_EXTENSION_NAME);
    array_add(*optional_extensions, "VK_KHR_win32_surface");
    array_add(*optional_extensions, "VK_KHR_wayland_surface");
    array_add(*optional_extensions, "VK_KHR_x11_surface");

    // find extensions
    enabled_extensions: [..] *u8;
    {
        count: u32;
        result = vkEnumerateInstanceExtensionProperties(null, *count, null);
        assert_vk_result(result);

        available_extensions: [..] VkExtensionProperties;
        array_resize(*available_extensions, count);

        result = vkEnumerateInstanceExtensionProperties(null, *count, available_extensions.data);
        assert_vk_result(result);

        for optional : optional_extensions {
            for available : available_extensions {
                if optional == to_string(available.extensionName) {
                    array_add(*enabled_extensions, optional.data);
                    break available;
                }
            }
        }
    }

    app_info: VkApplicationInfo;
    app_info.apiVersion = VK_API_VERSION_1_3;
    app_info.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
    app_info.engineVersion = VK_MAKE_VERSION(1, 0, 0);

    create_info: VkInstanceCreateInfo;
    create_info.pApplicationInfo = *app_info;
    create_info.enabledExtensionCount = enabled_extensions.count.(u32);
    create_info.ppEnabledExtensionNames = enabled_extensions.data;

    result = vkCreateInstance(*create_info, null, *vk_instance);
    assert_vk_result(result);
}

create_device :: () {
    auto_release_temp();
    push_allocator(temp);

    required_extensions: [..] *u8;
    array_add(*required_extensions, VK_KHR_DYNAMIC_RENDERING_EXTENSION_NAME);
    array_add(*required_extensions, VK_KHR_SWAPCHAIN_EXTENSION_NAME);

    result: VkResult;

    // pick the best physical device
    {
        device_handles: [..] VkPhysicalDevice;
        device_scores: [..] s32;

        physical_device_count: u32;
        result = vkEnumeratePhysicalDevices(vk_instance, *physical_device_count, null);
        assert_vk_result(result);

        array_resize(*device_handles, physical_device_count);
        array_resize(*device_scores, physical_device_count);
        result = vkEnumeratePhysicalDevices(vk_instance, *physical_device_count, device_handles.data);
        assert_vk_result(result);

        assert(physical_device_count > 0);


        for device_handles {
            device_properties: VkPhysicalDeviceProperties2;
            device_features: VkPhysicalDeviceFeatures2;
            vkGetPhysicalDeviceProperties2(it, *device_properties);
            vkGetPhysicalDeviceFeatures2(it, *device_features);

            limits_satisfied := device_properties.properties.limits.maxDescriptorSetStorageBuffers >= MAX_BUFFERS
                && device_properties.properties.limits.maxDescriptorSetStorageImages >= MAX_IMAGES
                && device_properties.properties.limits.maxDescriptorSetSampledImages >= MAX_IMAGES;
            
            if !limits_satisfied then continue;

            if device_properties.properties.deviceType == .DISCRETE_GPU {
                device_scores[it_index] += 1000;
            } else if device_properties.properties.deviceType == .VIRTUAL_GPU {
                device_scores[it_index] += 100;
            } else if device_properties.properties.deviceType == .INTEGRATED_GPU {
                device_scores[it_index] += 10;
            }
        }

        best_device_index: s64 = 0;
        best_score: s32 = 0;
        for device_scores {
            if it > best_score {
                best_score = it;
                best_device_index = it_index;
            }
        }

        assert(best_score > 0, "None of the available physical devices satisfy the minimum requirements!");
        vk_physical_device = device_handles[best_device_index];
        vkGetPhysicalDeviceProperties2(vk_physical_device, *vk_physical_device_properties);
    }

    // Set up the requests for queue creation
    queue_create_infos: [3] VkDeviceQueueCreateInfo;
    {
        queue_priorities := float.[0., 0., 0., 0.];
        queue_family_properties: [..] VkQueueFamilyProperties;
        supports_present: [..] bool;

        queue_family_count: u32;
        vkGetPhysicalDeviceQueueFamilyProperties(vk_physical_device, *queue_family_count, null);
        array_resize(*queue_family_properties, queue_family_count);
        array_resize(*supports_present, queue_family_count);
        vkGetPhysicalDeviceQueueFamilyProperties(vk_physical_device, *queue_family_count, queue_family_properties.data);

        Queue_Create_Info :: struct {
            family: u32 = U32_MAX;
            count: u32;
        }

        infos: [3] Queue_Create_Info;
        for queue_family_properties {
            supports_graphics := it.queueFlags & .GRAPHICS_BIT;
            supports_compute  := it.queueFlags & .COMPUTE_BIT;
            supports_transfer := it.queueFlags & .TRANSFER_BIT;

            // primary queue should support all operations
            if infos[0].family == U32_MAX && supports_graphics && supports_compute && supports_transfer {
                infos[0].family = it_index.(u32);
                infos[0].count = 1;
            }
            // compute queues should support compute/transfer
            if infos[1].family == U32_MAX && !supports_graphics && supports_compute && supports_transfer {
                infos[1] = .{
                    family = it_index.(u32),
                    count = min(it.queueCount, MAX_COMPUTE_QUEUES),
                };
            }
            if infos[2].family == U32_MAX && !supports_graphics && !supports_compute && supports_transfer {
                infos[2] = .{
                    family = it_index.(u32),
                    count = min(it.queueCount, MAX_TRANSFER_QUEUES),
                };
            }
        }

        for infos {
            queue_create_infos[it_index] = .{
                queueFamilyIndex = it.family,
                queueCount = it.count,
                pQueuePriorities = queue_priorities.data
            };
        }
    }

    // create the device:
    {
        chain: *void;
        dynamic_rendering := VkPhysicalDeviceDynamicRenderingFeatures.{ pNext = chain, dynamicRendering = VK_TRUE };
        chain = *dynamic_rendering;

        vk12_features := VkPhysicalDeviceVulkan12Features.{
            pNext = chain,
            timelineSemaphore = VK_TRUE,
            descriptorIndexing = VK_TRUE,
            shaderInputAttachmentArrayDynamicIndexing = VK_TRUE,
            shaderUniformTexelBufferArrayDynamicIndexing = VK_TRUE,
            shaderStorageTexelBufferArrayDynamicIndexing = VK_TRUE,
            shaderUniformBufferArrayNonUniformIndexing = VK_TRUE,
            shaderSampledImageArrayNonUniformIndexing = VK_TRUE,
            shaderStorageBufferArrayNonUniformIndexing = VK_TRUE,
            shaderStorageImageArrayNonUniformIndexing = VK_TRUE,
            shaderInputAttachmentArrayNonUniformIndexing = VK_TRUE,
            shaderUniformTexelBufferArrayNonUniformIndexing = VK_TRUE,
            shaderStorageTexelBufferArrayNonUniformIndexing = VK_TRUE,
            descriptorBindingUniformBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingSampledImageUpdateAfterBind = VK_TRUE,
            descriptorBindingStorageImageUpdateAfterBind = VK_TRUE,
            descriptorBindingStorageBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingUniformTexelBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingStorageTexelBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingUpdateUnusedWhilePending = VK_TRUE,
            descriptorBindingPartiallyBound = VK_TRUE,
            descriptorBindingVariableDescriptorCount = VK_TRUE,
            runtimeDescriptorArray = VK_TRUE,
            bufferDeviceAddress = VK_TRUE,
            storageBuffer8BitAccess = VK_TRUE,
            uniformAndStorageBuffer8BitAccess = VK_TRUE,
            storagePushConstant8 = VK_TRUE,
            shaderInt8 = VK_TRUE,
            shaderFloat16 = VK_TRUE,
            shaderBufferInt64Atomics = VK_TRUE,
            scalarBlockLayout = VK_TRUE,
            vulkanMemoryModel = VK_TRUE,
            vulkanMemoryModelDeviceScope = VK_TRUE,
        };
        chain = *vk12_features;

        vk11_features := VkPhysicalDeviceVulkan11Features.{
            pNext = chain,
            variablePointersStorageBuffer = VK_TRUE,
            variablePointers = VK_TRUE,
            storagePushConstant16 = VK_TRUE,
        };
        chain = *vk11_features;

        device_features := VkPhysicalDeviceFeatures.{
        };

        create_info := VkDeviceCreateInfo.{
            pNext = chain,
            queueCreateInfoCount = queue_create_infos.count.(u32),
            pQueueCreateInfos = queue_create_infos.data,

            enabledExtensionCount = required_extensions.count.(u32),
            ppEnabledExtensionNames = required_extensions.data,

            pEnabledFeatures = *device_features,
        };

        result = vkCreateDevice(vk_physical_device, *create_info, null, *vk_device);
        assert_vk_result(result);
    }

    // initialize the queues:
    {
        queue_index: u32 = 0;
        for queue_create_infos {
            for queue_index_in_family : 0..it.queueCount-1 {
                vkGetDeviceQueue(vk_device, it.queueFamilyIndex, queue_index_in_family, *queues[queue_index].queue);
                assert(queues[queue_index].queue != VK_NULL_HANDLE);
                queues[queue_index].family = it.queueFamilyIndex;
                queues[queue_index].index = queue_index_in_family;
                queue_index += 1;
            }
        }
    }

    // initialize VMA for memory allocations
    {
        memory_properties: VkPhysicalDeviceMemoryProperties;
        vkGetPhysicalDeviceMemoryProperties(vk_physical_device, *memory_properties);

        allocator_info := VmaAllocatorCreateInfo.{
            physicalDevice = vk_physical_device,
            device = vk_device,
            instance = vk_instance,
            vulkanApiVersion = VK_API_VERSION_1_3,
            flags = .BUFFER_DEVICE_ADDRESS_BIT,
        };

        result = vmaCreateAllocator(*allocator_info, *vma);
    }

    // load extension function pointers
    {
        vkCmdBeginRenderingKHR = cast(PFN_vkCmdBeginRenderingKHR) vkGetDeviceProcAddr(vk_device, "vkCmdBeginRenderingKHR");
        vkCmdEndRenderingKHR = cast(PFN_vkCmdEndRenderingKHR) vkGetDeviceProcAddr(vk_device, "vkCmdEndRenderingKHR");
        assert(vkCmdBeginRenderingKHR != null);
        assert(vkCmdEndRenderingKHR != null);
    }
}

vk_instance: VkInstance;
vk_physical_device: VkPhysicalDevice;
vk_physical_device_properties: VkPhysicalDeviceProperties2;
vk_device: VkDevice;
vma: VmaAllocator;

Queue :: struct {
    queue: VkQueue;
    family: u32;
    index: u32;
}

queues: [1 + 4 + 2] Queue;

MAX_BUFFERS :: 10000;
MAX_IMAGES :: 10000;

MAX_COMPUTE_QUEUES  :: 4;
MAX_TRANSFER_QUEUES :: 2;

vkCmdBeginRenderingKHR : PFN_vkCmdBeginRenderingKHR;
vkCmdEndRenderingKHR : PFN_vkCmdEndRenderingKHR;

#import,file "modules/Vulkan_With_VMA/module.jai";

#import "Basic";
#import "String";
#import "Math";