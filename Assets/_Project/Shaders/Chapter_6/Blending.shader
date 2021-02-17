﻿Shader "Custom/Blending"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "black" {} 
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}
        Blend DstColor Zero
       
        Pass
        {
            SetTexture [_MainTex] {combine texture}
        }
    }
 
}
