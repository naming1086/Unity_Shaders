Shader "Custom/Blend2Images"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "white" {} 
        _BlendTex ("BlendTex", 2D) = "white" {} 
        [Toggle] _IsBLend("IsBlend", float) = 0
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}
        Blend DstColor Zero
        CGPROGRAM
        #pragma surface surf Lambert
        struct Input
        {
            float2 uv_MainTex;
        };
        sampler2D _MainTex;
        sampler2D _BlendTex;
        float _IsBLend;
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 tex1 = tex2D(_MainTex, IN.uv_MainTex);
            float4 tex2 = tex2D(_BlendTex, IN.uv_MainTex);
            o.Albedo = tex1.rgb + tex2.rgb * _IsBLend;
        }
        
        ENDCG
    }
    FallBack "FallBack"
}
