Shader "Custom/Blending"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "black" {} 
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            SetTexture [_MainTex] {combine texture}
        }
    }
 
}
