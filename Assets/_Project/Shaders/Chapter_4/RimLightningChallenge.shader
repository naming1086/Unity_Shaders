Shader "Custom/Chalenge"
{
    Properties
    {
        _RimColor ("Color", Color) = (0,0.5,0.5,0)
        _RimPower("RimPower", Range(0, 15)) = 1
        _OutlineWidth("OutlineWidth", Range(0, 1)) = 0.2
        _LineWidth ("Line width", Range(0, 1)) = 0.1
        _LineColor ("Line Color", COLOR) = (1,1,1,1)
        _LineNumber("LineNumber", Range(0, 100)) = 10
        _EmissionTex("Emission", 2D) = "white"{}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        struct Input
        {
            float2 uv_EmissionTex;
            float3 viewDir;
            float3 worldPos;
        };
        
        fixed4 _RimColor;
        fixed4 _LineColor;
        float _RimPower;
        float _OutlineWidth;
        float _LineWidth;
        float _LineNumber;
        sampler2D _EmissionTex;

        void surf (Input IN, inout SurfaceOutput o)
        {
            float dp = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            dp = step(dp , _OutlineWidth);
         
            float3 fraction = step(_LineWidth, frac(IN.worldPos.y * _LineNumber * 0.5));
            if(fraction.y <= 0.2)
            {
                fraction += float3(1, 0,0);
            }
            else
                fraction += float3(0,1,0);
            o.Albedo = _RimColor.rgb *  pow(dp, _RimPower) * fraction;
            o.Emission = tex2D(_EmissionTex, IN.uv_EmissionTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
