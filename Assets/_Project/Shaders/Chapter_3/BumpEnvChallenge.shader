  Shader "Custom/BumpedEnvChallenge"
{
    Properties
    {
        _CubeMap ("CubeMap", CUBE) = "white" {}
        _MainBump ("NormalMap", 2D) = "bump" {}
        _Bumping("Bumping", Range(0,10)) = 1
        
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainBump;
        samplerCUBE _CubeMap;
        float _Bumping;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainBump ;
            float3 worldRefl; INTERNAL_DATA
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            //o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Brightness;
            o.Albedo = texCUBE(_CubeMap, WorldReflectionVector(IN,o.Normal)).rgb;
            o.Normal = UnpackNormal(tex2D(_MainBump, IN.uv_MainBump));
            o.Normal *= float3(_Bumping, _Bumping, _Bumping);
            //o.Emission = texCUBE(_CubeMap, WorldReflectionVector(IN,o.Normal)).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
