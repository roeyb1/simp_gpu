#scope_export

gpu_create_compute_pipeline :: (spirv: [] u8) -> Gpu_Pipeline {
    return 0;
}

gpu_create_graphics_pipeline :: (vertex_spirv: [] u8, pixel_spirv: [] u8, raster_desc: Gpu_Raster_Desc) -> Gpu_Pipeline {
    if vk_pipeline_layout == VK_NULL_HANDLE {
        create_global_pipeline_layout();
    }

    shader_stages: [2] VkPipelineShaderStageCreateInfo;

    // 16 seems like a reasonable cap on this to prevent heap allocating for no reason here.
    MAX_ATTACHMENTS :: 16;
    attachment_formats: [MAX_ATTACHMENTS] VkFormat;

    assert(raster_desc.color_targets.count < attachment_formats.count);
    for raster_desc.color_targets {
        attachment_formats[it_index] = it.format.(VkFormat);
    }

    pipeline_rendering_create_info := VkPipelineRenderingCreateInfo.{
        viewMask = 0,
        colorAttachmentCount = raster_desc.color_targets.count.(u32),
        pColorAttachmentFormats = attachment_formats.data,
        depthAttachmentFormat = raster_desc.depth_format.(VkFormat),
        stencilAttachmentFormat = raster_desc.stencil_format.(VkFormat),
    };

    input_assembly_state := VkPipelineInputAssemblyStateCreateInfo.{
        topology = raster_desc.topology.(VkPrimitiveTopology),
        primitiveRestartEnable = VK_FALSE,
    };

    rasterization_state := VkPipelineRasterizationStateCreateInfo.{
        depthClampEnable = VK_FALSE,
        rasterizerDiscardEnable = VK_FALSE,
        polygonMode = .FILL,
        cullMode = raster_desc.cull.(VkCullModeFlags),
        frontFace = .COUNTER_CLOCKWISE,
        lineWidth = 1.,
    };

    multisample_state := VkPipelineMultisampleStateCreateInfo.{
        rasterizationSamples = raster_desc.sample_count.(VkSampleCountFlagBits),
        alphaToCoverageEnable = raster_desc.alpha_to_coverage.(VkBool32),
    };

    assert(raster_desc.blend_state != null, "dynamic blend state is not yet implemented");
    attachment_blend_states: [MAX_ATTACHMENTS] VkPipelineColorBlendAttachmentState;
    for 0..raster_desc.color_targets.count-1 {
        attachment_blend_states[it] = .{
            blendEnable = VK_TRUE,
            srcColorBlendFactor = raster_desc.blend_state.src_color_factor.(VkBlendFactor),
            dstColorBlendFactor = raster_desc.blend_state.dst_color_factor.(VkBlendFactor),
            colorBlendOp = raster_desc.blend_state.color_op.(VkBlendOp),
            srcAlphaBlendFactor = raster_desc.blend_state.src_alpha_factor.(VkBlendFactor),
            dstAlphaBlendFactor = raster_desc.blend_state.dst_alpha_factor.(VkBlendFactor),
            alphaBlendOp = raster_desc.blend_state.alpha_op.(VkBlendOp),
            colorWriteMask = raster_desc.blend_state.color_write_mask.(VkColorComponentFlagBits),
        };
    }

    color_blend_state := VkPipelineColorBlendStateCreateInfo.{
        logicOpEnable = VK_FALSE,
        //logicOp
        attachmentCount = attachment_blend_states.count.(u32),
        pAttachments = attachment_blend_states.data,
    };

    dynamic_states := VkDynamicState.[
        .VIEWPORT, .SCISSOR, .DEPTH_BIAS, .DEPTH_TEST_ENABLE, .DEPTH_WRITE_ENABLE, .DEPTH_COMPARE_OP,
        // Fill some more space which can be filled by optional dynamic state:
        .MAX_ENUM, .MAX_ENUM, .MAX_ENUM, .MAX_ENUM, .MAX_ENUM, .MAX_ENUM,
    ];
    num_dynamic_states := array_find(dynamic_states, .MAX_ENUM);

    dynamic_state := VkPipelineDynamicStateCreateInfo.{
        dynamicStateCount = num_dynamic_states.(u32),
        pDynamicStates = dynamic_states.data
    };

    // #todo:
    //if !raster_desc.blend_state {
    //    dynamic_states[num_dynamic_states] = .COLOR_BLEND_ENABLE;
    //    num_dynamic_states += 1;
    //}

    pipeline_create_info := VkGraphicsPipelineCreateInfo.{
        pNext = *pipeline_rendering_create_info,
        stageCount = shader_stages.count.(u32),
        pStages = shader_stages.data,
        //pVertexInputState,
        pInputAssemblyState = *input_assembly_state,
        pRasterizationState = *rasterization_state,
        pMultisampleState = *multisample_state,
        pColorBlendState = *color_blend_state,
        pDynamicState = *dynamic_state,
        layout = vk_pipeline_layout,
        subpass = 0,
        basePipelineHandle = VK_NULL_HANDLE,
        basePipelineIndex = 0,
    };

    vk_pipeline: VkPipeline;
    vk_result := vkCreateGraphicsPipelines(vk_device, null, 1, *pipeline_create_info, null, *vk_pipeline);
    
    pool_add(*live_pipelines, .{.GRAPHICS, vk_pipeline});
    return 0;
}

gpu_free_pipeline :: (pipeline: Gpu_Pipeline) {

}

#scope_module

Pipeline_Type :: enum {
    GRAPHICS;
    COMPUTE;
}

Pipeline :: struct {
    type: Pipeline_Type;

    vk_pipeline: VkPipeline;
}

// we always use the same push constant block size and same descriptor sets so there is no need to have multiple pipeline layouts.
vk_pipeline_layout: VkPipelineLayout;
live_pipelines: Pool(Gpu_Pipeline, Pipeline);

create_global_pipeline_layout :: () {
    // #todo: setup push consts to pass the single parameter block buffer pointer
    create_info := VkPipelineLayoutCreateInfo.{
        setLayoutCount = 1,
        pSetLayouts = *bindless_set_layout,
    };
    vk_result := vkCreatePipelineLayout(vk_device, *create_info, null, *vk_pipeline_layout);
    assert_vk_result(vk_result);
}