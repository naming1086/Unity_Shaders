Shader "Custom/OwnLightningModelToon"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex("ToonTex", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
     
        CGPROGRAM
        fixed4 _Color;
        sampler2D _RampTex;
        
        #pragma surface surf Toon
        half4 LightingToon(SurfaceOutput so, half3 lightDir ,half atten)
        {
            float diffuse = dot(so.Normal, lightDir);
            float h = diffuse * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;
            float4 color;
            color.rgb = so.Albedo  * _LightColor0 * ramp;
            color.a = so.Alpha;
            return color;
        }

        struct Input
        {
            float2 uv_MainTex;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
           o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
