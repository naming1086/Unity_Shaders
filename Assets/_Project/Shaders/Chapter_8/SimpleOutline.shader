Shader "Custom/Simple outline"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "white" {}
        _OutlineWith ("OutlineWith", Range(-.1,.1)) = 0
        _OutlineColor("OutlineColor", COLOR) = (1,1,1,1)
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}
        ZWrite off
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        float _OutlineWith;
        float4 _OutlineColor;
        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
        };

        void vert (inout appdata v)
        {
            v.vertex.xyz += v.normal * _OutlineWith;
        }
        
        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor;
        }
        ENDCG
        
        ZWrite on
        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainTex;
        float _OutlineWith;
        float4 _OutlineColor;
        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
