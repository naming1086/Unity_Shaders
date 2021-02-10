Shader "Course/FirstSurfShader"
{
    Properties 
    {
        _MyColor ("Color", COLOR) = (1,1,1,1)
        _MyNormal ("Normal", COLOR) = (1,1,1,1)
        _MyEmission ("Emission", COLOR) = (1,1,1,1)
    }
    SubShader 
    {
         CGPROGRAM
         #pragma surface surf Lambert
         struct Input
         {
             float2 uvMainTex;  
         };
         fixed4 _MyColor;
         fixed4 _MyEmission;
         fixed4 _MyNormal;
         
         void surf(Input IN , inout SurfaceOutput output)
         {
             output.Albedo = _MyColor.rgb;
             output.Emission = _MyEmission.rgb;
             output.Normal = _MyNormal.rgb;
         }
         ENDCG
    }
    FallBack "Diffuse"
}
