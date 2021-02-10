Shader "Posmac/ShaderPropChallenge_2"
{
    Properties
    {
        _myTex ("Example Texture", 2D) = "white" {}
    }
    Subshader
    {
        CGPROGRAM
        #pragma surface surf Lambert

       
        sampler2D _myTex;
       
        
        struct Input
        {
            float2 uv_myTex;
        };

        void surf(Input IN, inout SurfaceOutput output)
        {
            output.Albedo = tex2D(_myTex, IN.uv_myTex).rgb;
            output.Albedo.g = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
} 