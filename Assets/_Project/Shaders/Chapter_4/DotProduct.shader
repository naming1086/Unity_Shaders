Shader "Custom/DotProduct"
{
    Properties
    {
        _Color("Color", COLOR) = (1,1,1,1)
    }
    SubShader
    {
      
        CGPROGRAM

        #pragma surface surf Lambert 

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 Normal;
            float3 viewDir;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

      
        void surf (Input IN, inout SurfaceOutput o)
        {
            float dotProd = dot(IN.viewDir, o.Normal) * _Color;
            o.Albedo = float3(dotProd , 1,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
