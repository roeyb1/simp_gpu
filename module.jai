#module_parameters(VALIDATION := false);

Gpu_Pipeline :: #type,distinct u64;

Gpu_Texture :: #type,distinct u64;

Gpu_Depth_Stencil_State :: #type,distinct u64;

Gpu_Blend_State :: #type,distinct u64;

Gpu_Queue :: #type,distinct u64;

Gpu_Command_Buffer :: #type,distinct u64;

Gpu_Semaphore :: #type,distinct u64;

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

Gpu_Queue_Type :: enum u8 {
    MAIN        :: 0;
    COMPUTE     :: 1;
    TRANSFER    :: 2;
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

// ----------------------------- Global ------------------------------------

gpu_init :: () {
    create_instance();
    create_device();
}

gpu_shutdown :: () {
    vkDeviceWaitIdle(vk_device);

    gpu_collect_garbage();

    for arena : cmd_pools {
        for arena.all_pools {
            vkDestroyCommandPool(vk_device, it.vk_cmd_pool, null);
        }
    }

    for queues {
        vkDestroySemaphore(vk_device, it.timeline, null);
    }

    #if VALIDATION {
        vkDestroyDebugReportCallbackEXT: PFN_vkDestroyDebugReportCallbackEXT = xx vkGetInstanceProcAddr(vk_instance, "vkDestroyDebugReportCallbackEXT");
        if vkDestroyDebugReportCallbackEXT != null {
            vkDestroyDebugReportCallbackEXT(vk_instance, vk_debug_callback_handle, null);
        }
    }
    vmaDestroyAllocator(vma);
    vkDestroyDevice(vk_device, null);
    vkDestroyInstance(vk_instance, null);
}

gpu_collect_garbage :: () {
    reclaim_completed_command_pools();
}

// #TODO: is this required as part of the public api?
gpu_wait_idle :: () {
    vkDeviceWaitIdle(vk_device);
}

// ----------------------------- Textures ------------------------------------

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
    for queues {
        if it.type == queue_type && it.index == queue_index then return (it_index + 1).(Gpu_Queue);
    }
    return 0;
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

#load "memory.jai";
#load "command_buffer.jai";

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
    #if VALIDATION {
        array_add(*enabled_extensions, VK_EXT_DEBUG_REPORT_EXTENSION_NAME);
        array_add(*enabled_extensions, VK_EXT_DEBUG_UTILS_EXTENSION_NAME);
    }
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
    #if VALIDATION {
        create_info.enabledLayerCount = 1;
        create_info.ppEnabledLayerNames = (*u8).["VK_LAYER_KHRONOS_validation"].data;

        enabled_validation_features := VkValidationFeatureEnableEXT.[
            //.GPU_ASSISTED_EXT,
            //.GPU_ASSISTED_RESERVE_BINDING_SLOT_EXT,
        ];

        validation_features := VkValidationFeaturesEXT.{
            enabledValidationFeatureCount = enabled_validation_features.count,
            pEnabledValidationFeatures  = enabled_validation_features.data,
        };

        debug_messenger_create_info := VkDebugUtilsMessengerCreateInfoEXT.{
            messageSeverity = .WARNING_BIT_EXT | .ERROR_BIT_EXT,
            messageType = .GENERAL_BIT_EXT | .VALIDATION_BIT_EXT | .PERFORMANCE_BIT_EXT,
            pfnUserCallback = vk_debug_callback,
            pUserData = null,
            pNext = *validation_features,
        };

        create_info.pNext = *debug_messenger_create_info;
    }

    result = vkCreateInstance(*create_info, null, *vk_instance);
    assert_vk_result(result);

    #if VALIDATION {
        vkCreateDebugReportCallbackEXT: PFN_vkCreateDebugReportCallbackEXT = xx vkGetInstanceProcAddr(vk_instance, "vkCreateDebugReportCallbackEXT");

        if vkCreateDebugReportCallbackEXT {
            debug_callback_create_info: VkDebugReportCallbackCreateInfoEXT;
            debug_callback_create_info.flags |= .ERROR_BIT_EXT;
            debug_callback_create_info.flags |= .WARNING_BIT_EXT;
            debug_callback_create_info.pfnCallback = vk_validation_callback;

            vkCreateDebugReportCallbackEXT(vk_instance, *debug_callback_create_info, null, *vk_debug_callback_handle);
        }
    }
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
            bufferDeviceAddress = VK_TRUE,
            bufferDeviceAddressCaptureReplay = VK_TRUE,
            descriptorBindingPartiallyBound = VK_TRUE,
            descriptorBindingSampledImageUpdateAfterBind = VK_TRUE,
            descriptorBindingStorageBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingStorageImageUpdateAfterBind = VK_TRUE,
            descriptorBindingStorageTexelBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingUniformBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingUniformTexelBufferUpdateAfterBind = VK_TRUE,
            descriptorBindingUpdateUnusedWhilePending = VK_TRUE,
            descriptorBindingVariableDescriptorCount = VK_TRUE,
            descriptorIndexing = VK_TRUE,
            runtimeDescriptorArray = VK_TRUE,
            scalarBlockLayout = VK_TRUE,
            shaderBufferInt64Atomics = VK_TRUE,
            shaderFloat16 = VK_TRUE,
            shaderInputAttachmentArrayDynamicIndexing = VK_TRUE,
            shaderInputAttachmentArrayNonUniformIndexing = VK_TRUE,
            shaderInt8 = VK_TRUE,
            shaderSampledImageArrayNonUniformIndexing = VK_TRUE,
            shaderStorageBufferArrayNonUniformIndexing = VK_TRUE,
            shaderStorageImageArrayNonUniformIndexing = VK_TRUE,
            shaderStorageTexelBufferArrayDynamicIndexing = VK_TRUE,
            shaderStorageTexelBufferArrayNonUniformIndexing = VK_TRUE,
            shaderUniformBufferArrayNonUniformIndexing = VK_TRUE,
            shaderUniformTexelBufferArrayDynamicIndexing = VK_TRUE,
            shaderUniformTexelBufferArrayNonUniformIndexing = VK_TRUE,
            storageBuffer8BitAccess = VK_TRUE,
            storagePushConstant8 = VK_TRUE,
            timelineSemaphore = VK_TRUE,
            uniformAndStorageBuffer8BitAccess = VK_TRUE,
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
                vkGetDeviceQueue(vk_device, it.queueFamilyIndex, queue_index_in_family, *queues[queue_index].vk_queue);
                assert(queues[queue_index].vk_queue != VK_NULL_HANDLE);

                queues[queue_index].vk_family = it.queueFamilyIndex;

                queue_index += 1;
            }
            all_queue_family_indices[it_index] = it.queueFamilyIndex;
        }

        // create the timeline semaphores for each queue:
        for * queues {
            timeline_create_info := VkSemaphoreTypeCreateInfo.{
                semaphoreType = .TIMELINE,
                initialValue = 0
            };
            create_info := VkSemaphoreCreateInfo.{
                pNext = *timeline_create_info,
            };

            result = vkCreateSemaphore(vk_device, *create_info, null, *it.timeline);
            assert_vk_result(result);
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
        assert_vk_result(result);
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
    vk_queue: VkQueue;
    vk_family: u32;
    index: u32;
    type: Gpu_Queue_Type;
    
    timeline: VkSemaphore;
    timeline_value: u64;
}

queues := Queue.[
    .{type = .MAIN, index = 0},
    .{type = .COMPUTE, index = 0},
    .{type = .COMPUTE, index = 1},
    .{type = .COMPUTE, index = 2},
    .{type = .COMPUTE, index = 3},
    .{type = .TRANSFER, index = 0},
    .{type = .TRANSFER, index = 1},
];

/** The number of queue families should always at most one per queue type. */
NUM_QUEUE_FAMILIES :: #run enum_highest_value(Gpu_Queue_Type) + 1;

all_queue_family_indices: [NUM_QUEUE_FAMILIES] u32;

get_queue :: (queue_handle: Gpu_Queue) -> *Queue {
    queue_index := queue_handle - 1;
    assert(queue_index < queues.count);
    return *queues[queue_index];
}


MAX_BUFFERS :: 10000;
MAX_IMAGES  :: 10000;

MAX_COMPUTE_QUEUES  :: 4;
MAX_TRANSFER_QUEUES :: 2;

vkCmdBeginRenderingKHR : PFN_vkCmdBeginRenderingKHR;
vkCmdEndRenderingKHR : PFN_vkCmdEndRenderingKHR;

#if VALIDATION {
    vk_debug_callback_handle: VkDebugReportCallbackEXT;

    vk_validation_callback :: (flags: VkDebugReportFlagsEXT, objType: VkDebugReportObjectTypeEXT, obj: u64, location: u64, code: s32, layerPrefix: *u8, msg: *u8, userData: *void) -> VkBool32 #c_call {
        new_context: #Context;
        push_context new_context {
            log("Vulkan Validation: %", to_string(msg));
        }
        
        return VK_FALSE;
    }

    vk_debug_callback :: (messageSeverity: VkDebugUtilsMessageSeverityFlagBitsEXT, messageTypes: VkDebugUtilsMessageTypeFlagsEXT, pCallbackData: *VkDebugUtilsMessengerCallbackDataEXT, pUserData: *void) -> VkBool32 #c_call {
        new_context: #Context;
        push_context new_context {
            if messageSeverity == {
                case .WARNING_BIT_EXT;
                    log("Vulkan debug: %", to_string(pCallbackData.pMessage));
                case .ERROR_BIT_EXT;
                    log("Vulkan debug: %", to_string(pCallbackData.pMessage));
            }
        }

        return VK_FALSE;
    }
}

#import,file "modules/Vulkan_With_VMA/module.jai";

#import "Basic";
#import "String";
#import "Math";
#import "Bucket_Array";
#import "Atomics";