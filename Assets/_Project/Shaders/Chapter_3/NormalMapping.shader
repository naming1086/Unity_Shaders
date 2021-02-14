  Shader "Custom/NormalMapping"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainBump ("Bump", 2D) = "bump" {}
        _Bumping("Bumping", Range(0,10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        sampler2D _MainBump;
        float _Bumping;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainBump;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_MainBump, IN.uv_MainBump));
            o.Normal *= float3(_Bumping, _Bumping, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
