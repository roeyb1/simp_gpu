struct PS_Input {
}

[shader("pixel")]
float4 main(PS_Input input) : SV_Target0 {
    return float4(1, 0, 0, 1.);
}