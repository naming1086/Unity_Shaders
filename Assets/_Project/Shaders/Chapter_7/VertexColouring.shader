Shader "Unlit/FragmentColouring"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color.r = v.vertex.x;
                o.color.g = 0;
                o.color.b = 0;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col;
                col = i.color;
                return col;
            }
            ENDCG
        }
    }
}
