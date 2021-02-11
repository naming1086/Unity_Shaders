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
            float3 worldPos;
        };
        
        fixed4 _RimColor;
        float _RimPower;
        float _OutlineWidth;
        void surf (Input IN, inout SurfaceOutput o)
        {
            float dp = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            dp = step(dp , _OutlineWidth);
            float3 fraction = frac(IN.worldPos.y * 10 * 0.5);
            fraction.y = step(fraction.y, 0.1);
            o.Albedo = _RimColor.rgb *  pow(dp, _RimPower) * fraction;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
