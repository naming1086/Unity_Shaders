Shader "Custom/StandartPBRSpecularC1"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor ("SpecColor", Color) = (1,1,1,1)
        _MetallicTex ("MetallicTex", 2D) = "white"{}
        _Emission("Emission", Range(0, 10)) = 1
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        CGPROGRAM
        
        #pragma surface surf StandardSpecular 

    
        sampler2D _MetallicTex;
        fixed4 _Color;
        float _Emission;
      
        
        struct Input
        {
            float2 uv_MetallicTex;
        };
    
        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
              o.Albedo = _Color.rgb;
              o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
              o.Specular = _SpecColor.rgb;
              o.Emission = tex2D(_MetallicTex, IN.uv_MetallicTex) * _Emission;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
