Shader "Custom/MaterialUsing"
{
    Properties
    {
        _MainTexture("Maintexture", 2D) = "white"{}    
        _Scale_UV_X("Scale X", Range(0, 10)) = 1 
        _Scale_UV_Y("Scale Y", Range(0, 10)) = 1 
    }
    SubShader
    {        
        Tags { "Queue"="Transparent" }
        GrabPass{}
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTexture;
            float4 _MainTexture_ST;
            float _Scale_UV_X;
            float _Scale_UV_Y;
            sampler2D _GrabTexture;
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTexture);
                o.uv.x = sin(o.uv.x * _Scale_UV_X) ;
                o.uv.y = sin(o.uv.y  * _Scale_UV_Y);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_GrabTexture, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
