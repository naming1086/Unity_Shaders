﻿Shader "Custom/RimLightning"
{
    Properties
    {
        _RimColor ("Color", Color) = (0,0.5,0.5,0)
        _RimPower("RimPower", Range(0, 15)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        struct Input
        {
            float3 viewDir;
        };
        
        fixed4 _RimColor;
        float _RimPower;
        void surf (Input IN, inout SurfaceOutput o)
        {
            float dp = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Albedo = _RimColor.rgb *  pow(dp, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
