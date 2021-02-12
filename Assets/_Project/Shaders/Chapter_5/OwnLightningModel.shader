Shader "Custom/OwnLightningModel"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
     
        CGPROGRAM
        
        #pragma surface surf BasicLambert
        half4 LightingBasicLambert(SurfaceOutput so, half3 lightDir, half atten)
        {
            half NdotL = dot(normalize(so.Normal), normalize(lightDir));
            half4 color;
            color.rgb = so.Albedo * _LightColor0 * (NdotL * atten);
            color.a = so.Alpha;
            return color;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;


        void surf (Input IN, inout SurfaceOutput o)
        {
           o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
