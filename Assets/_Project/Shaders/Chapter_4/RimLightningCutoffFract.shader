Shader "Custom/RimLightning"
{
    Properties
    {
        _RimColor ("Color", Color) = (0,0.5,0.5,0)
        _RimPower("RimPower", Range(0, 15)) = 1
        _OutlineWidth("OutlineWidth", Range(0, 1)) = 0.2
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
        float _OutlineWidth;
        void surf (Input IN, inout SurfaceOutput o)
        {
            float dp = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            dp = step(dp , _OutlineWidth);
            o.Albedo = _RimColor.rgb *  pow(dp, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
