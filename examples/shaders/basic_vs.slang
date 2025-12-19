struct VS_Output {
    float4 position : SV_POSITION;
}

struct Push_Consts {
    float2* positions;
};

[vk::push_constant]
Push_Consts pc;

[shader("vertex")]
VS_Output main(uint vertex_id: SV_VertexID) {
    VS_Output output;
    output.position = float4(pc.positions[vertex_id], 0., 1.);
    return output;
}