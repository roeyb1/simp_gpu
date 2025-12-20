#scope_export

#if ENABLE_RENDER_CAPTURE {

    gpu_capture_start :: () {
        rdoc_api.StartFrameCapture(null, null);
    }

    gpu_capture_end :: () {
        if rdoc_api {
            rdoc_api.EndFrameCapture(null, null);
        }
    }

    gpu_scoped_capture :: () #expand {
        gpu_capture_start();

        `defer gpu_capture_end();
    }

#scope_module

    gpu_capture_init :: () {
        init_renderdoc();
    }

#scope_file

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

    #import,file "modules/renderdoc/module.jai";
} else {
    gpu_capture_start :: () {
    }

    gpu_capture_end :: () {
    }

    gpu_scoped_capture :: () #expand {
    }
}