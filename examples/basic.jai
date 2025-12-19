main :: () {
    //init_renderdoc();
    gpu_init();

    transfer_queue := gpu_get_queue(.TRANSFER, 0);

    {
        buffer_size := 1024;
        ptr, staging_ptr := gpu_malloc(buffer_size);
        _, gpu_ptr := gpu_malloc(buffer_size, .GPU);

        memset(ptr, 255, buffer_size);

        cmd_buff := gpu_start_command_recording(transfer_queue);

        gpu_memcpy(cmd_buff, gpu_ptr, staging_ptr, buffer_size);

        gpu_submit(transfer_queue, cmd_buff);

        gpu_wait_idle();


        gpu_free(ptr);
        gpu_free(gpu_ptr);
    }

    {
        semaphore := gpu_create_semaphore(0);

        gpu_wait_semaphore(semaphore, 0);
        gpu_destroy_semaphore(semaphore);
    }

    main_queue := gpu_get_queue(.MAIN, 0);
    c1_queue := gpu_get_queue(.COMPUTE, 0);
    c2_queue := gpu_get_queue(.COMPUTE, 1);

    {
        vertex_file, _ := read_entire_file("shaders/basic_vs.spv");
        pixel_file, _ := read_entire_file("shaders/basic_ps.spv");
        vertex_spv: [] u8;
        vertex_spv.data = vertex_file.data;
        vertex_spv.count = vertex_file.count;
        pixel_spv: [] u8;
        pixel_spv.data = pixel_file.data;
        pixel_spv.count = pixel_file.count;


        blend_state: Gpu_Blend_Desc;
        raster_desc := Gpu_Raster_Desc.{
            cull = .CW,
            color_targets = .[
                .{format = .R8G8B8A8_UNORM}
            ],
            blend_state = *blend_state,
        };

        graphics_pipeline := gpu_create_graphics_pipeline(vertex_spv, pixel_spv, raster_desc);

        texture_desc := Gpu_Texture_Desc.{
            format = .R8G8B8A8_UNORM,
            dimensions = .[1024, 1024, 1],
            usage = .COLOR_ATTACHMENT
        };
        texture := gpu_create_texture(texture_desc);
        view := gpu_texture_view(texture);

        Vertex2D :: struct {
            x: float;
            y: float;
        }
        vertex_buffer_ptr, vertex_gpu := gpu_malloc(6 * size_of(float));
        vertex_buffer := cast(*Vertex2D) vertex_buffer_ptr;
        vertex_buffer[0] = .{-0.5, +0.5};
        vertex_buffer[1] = .{+0.0, -0.5};
        vertex_buffer[2] = .{+0.5, +0.5};

        index_buffer_ptr, index_gpu := gpu_malloc(3 * size_of(u32));
        index_buffer := cast(*u32) index_buffer_ptr;
        index_buffer[0] = 0;
        index_buffer[1] = 1;
        index_buffer[2] = 2;

        //rdoc_api.StartFrameCapture(null, null);

        cmd_buff := gpu_start_command_recording(main_queue);
        {
            render_desc := Gpu_Render_Pass_Desc.{
                color_targets = .[
                    .{
                        view = view,
                        load_op = .CLEAR,
                        store_op = .STORE,
                        clear_color = .[0, 0, 0, 1],
                    }
                ]
            };
            gpu_begin_render_pass(cmd_buff, render_desc);

            gpu_set_pipeline(cmd_buff, graphics_pipeline);
            gpu_draw_indexed_instanced(cmd_buff, vertex_gpu, index_gpu, 3, 1);

            gpu_end_render_pass(cmd_buff);
        }

        gpu_submit(main_queue, cmd_buff);

        gpu_wait_idle();

        //assert(rdoc_api.EndFrameCapture(null, null) == 1);

        gpu_free(vertex_buffer);
        gpu_free(index_buffer);
        gpu_free_pipeline(graphics_pipeline);
        gpu_free(texture);
    }

    //for 0..200 {
    //    for 0..127 {
    //        cmd_buff := gpu_start_command_recording(main_queue);

    //        gpu_submit(main_queue, cmd_buff);

    //        cmd_buff = gpu_start_command_recording(c1_queue);
    //        gpu_submit(c1_queue, cmd_buff);

    //        cmd_buff = gpu_start_command_recording(c2_queue);
    //        gpu_submit(c1_queue, cmd_buff);
    //    }

    //    gpu_wait_idle();
    //}

    gpu_shutdown();
}

init_renderdoc :: () {
    #if OS == .LINUX {
        #import "POSIX";

        mod := dlopen("./librenderdoc.so", RTLD_NOW | RTLD_GLOBAL);
        assert(mod != null);
        get_api := cast(pRENDERDOC_GetAPI)dlsym(mod, "RENDERDOC_GetAPI");
    } else {
        #import "Windows";

        mod := GetModuleHandleA("renderdoc.dll");
        assert(mod != null);
        get_api := cast(pRENDERDOC_GetAPI)GetProcAddress(mod, "RENDERDOC_GetAPI");
    }

    ret := get_api(.eRENDERDOC_API_Version_1_6_0, cast(**void)(*rdoc_api));
    assert(ret == 1);
}

rdoc_api: *RENDERDOC_API_1_6_0;

#import,file "../../simp_gpu/module.jai"(VALIDATION = true);
#import,file "../../simp_gpu/modules/renderdoc/module.jai";
#import "File";

#import "Basic";
