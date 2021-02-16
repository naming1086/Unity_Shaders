Shader "Custom/OwnLightningModelBlinn"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
     
        CGPROGRAM
        
        #pragma surface surf BasicBlinn
        half4 LightingBasicBlinn(SurfaceOutput so, half3 lightDir, half3 viewDir ,half atten)
        {
            half3 h = normalize(lightDir + viewDir);
            half diff = max(0, dot(so.Normal, lightDir));
            float nh = max(0, dot(so.Normal, h));
            float spec = pow(nh, 48);
            half4 color;
            color.rgb =  (so.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime;
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
