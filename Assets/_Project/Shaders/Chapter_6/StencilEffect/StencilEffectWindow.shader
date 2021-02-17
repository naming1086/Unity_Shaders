Shader "Custom/StenciEffectlWindow"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "white" {}
        _SRef("Stencil ref", float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp ("Stencil compare", Float ) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp ("Stencil operation", Float ) = 2
        
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }
        ZWrite off
        ColorMask 0
        Stencil
        {
            Ref [_SRef]
            Comp [_SComp]
            Pass [_SOp]
        }
        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainTex;
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o)
        {
           fixed4 color = tex2D(_MainTex, IN.uv_MainTex);
           o.Albedo = color.rgb;
           //o.Alpha = color.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
