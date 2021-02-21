Shader "Custom/WavesShader"
{
    Properties
    {
        _ColorTint ("Color Tint", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Amp("Wave amplitude", Range(0, 10)) = 1
        _Freq("Frequency", Range(0, 10)) = 1
        _Speed("Speed", Range(0, 20)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        
        sampler2D _MainTex;
        float4 _ColorTint;
        float _Amp;
        float _Freq;
        float _Speed;
        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
        };

        
        struct Input
        {
            float2 uv_MainTex;
            float3 vertColor;
        };
        void vert (inout appdata v, out Input i)
        {
            UNITY_INITIALIZE_OUTPUT(Input, i);
            float t = _Time * _Speed;
            float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp +
                        sin(t*2 + v.vertex.x * _Freq*2) * _Amp;
            v.vertex.y += waveHeight;
            v.normal = float3(v.normal.x + waveHeight, v.normal.y, v.normal.z);
            i.vertColor = waveHeight+2;
        }
        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c * IN.vertColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
