Shader "Custom/StencilEffectObject"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Diffuse("Diffuse Texture", 2D) = "white"{}
        _Bump("Bump Texture", 2D) = "bump"{}
        _Slider("Bump strenght", Range(0, 10)) = 1
        
        _SRef("Stencil ref", float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp ("Stencil compare", Float ) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp ("Stencil operation", Float ) = 2
        
    }
    SubShader
    {
        Stencil
        {
            Ref [_SRef]
            Comp [_SComp]
            Pass [_SOp]
        }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _Diffuse;
        sampler2D _Bump;
        float _Slider;
        fixed4 _Color;
        
        struct Input
        {
            float2 uv_Diffuse;
            float2 uv_Bump;
        };
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_Diffuse, IN.uv_Diffuse).rgb;
            o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
            o.Normal *= float3(_Slider,_Slider, 0);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
