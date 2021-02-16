Shader "Custom/AlphaChannelBegin"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        sampler2D _MainTex;
        struct Input
        {
            float2 uv_MainTex;
        };
        
        fixed4 _Color;
        
        void surf (Input IN, inout SurfaceOutput o)
        {
           fixed4 color = tex2D(_MainTex, IN.uv_MainTex);
           o.Albedo = color.rgb * _Color;
           o.Alpha = color.a * _Color.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
