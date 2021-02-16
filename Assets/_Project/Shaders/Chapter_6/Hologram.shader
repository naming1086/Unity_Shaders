Shader "Custom/Hologram"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor ("Color", Color) = (0,0.5,0.5,0)
        _RimPower("RimPower", Range(0, 15)) = 1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        Pass
        {
            ZWrite On
            ColorMask 0
        }
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        sampler2D _MainTex;
        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };
        
        fixed4 _Color;
        fixed4 _RimColor;
        float _RimPower;
        
        void surf (Input IN, inout SurfaceOutput o)
        {
           float dp = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
           fixed4 color = tex2D(_MainTex, IN.uv_MainTex);
           //o.Albedo = color.rgb * _Color;
           //o.Alpha = color.a * _Color.a;
           o.Emission = _RimColor.rgb * pow(dp, _RimPower) * 10;
           o.Alpha = pow(dp, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
