#run,stallable {
    set_build_options_dc(.{do_output=false});
    opts: Generate_Bindings_Options;
    array_add(*opts.source_files, "renderdoc_app.h");
    if !generate_bindings(opts, "module.jai") {
        compiler_report("Failed to generate bindings.");
    }
}

#import "Basic";
#import "Bindings_Generator";
#import "Compiler";