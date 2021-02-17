Shader "Custom/Cullong"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "black" {} 
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha
        Cull Off
        
        Pass
        {
            SetTexture [_MainTex] {combine texture}
        }
    }
 
}
