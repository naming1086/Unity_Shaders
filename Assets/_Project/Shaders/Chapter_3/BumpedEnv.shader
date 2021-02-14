  Shader "Custom/BumpedEnv"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainBump ("Bump", 2D) = "bump" {}
        _Bumping("Bumping", Range(0,10)) = 1
        _Brightness("Brightness", Range(0,10)) = 1
        _Scale("Scale", Range(-10,10)) = 1
        _CubeMap ("CubeMap", CUBE) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        sampler2D _MainBump;
        samplerCUBE _CubeMap;
        float _Bumping;
        float _Scale;
        float _Brightness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainBump ;
            float3 worldRefl; INTERNAL_DATA
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Brightness;
            o.Normal = UnpackNormal(tex2D(_MainBump, IN.uv_MainBump * _Scale));
            o.Normal *= float3(_Bumping, _Bumping, 1);
            o.Emission = texCUBE(_CubeMap, WorldReflectionVector(IN,o.Normal)).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
