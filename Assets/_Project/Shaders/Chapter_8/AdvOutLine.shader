Shader "Custom/AdvOutline"
{
    Properties
    {
        _MainTex ("Albedo", 2D) = "white" {}
        _OutlineWith ("OutlineWith", Range(-.1,.1)) = 0
        _OutlineColor("OutlineColor", COLOR) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainTex;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }
        ENDCG
    	
        Pass
        {
            Cull Front
            CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
				
			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
			};
			
			float _OutlineWith;
			float4 _OutlineColor;
			
			v2f vert(appdata v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);

				float3 norm   = normalize(mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(norm.xy);

				o.pos.xy += offset * o.pos.z * _OutlineWith;
				o.color = _OutlineColor;
				return o;
			}


			fixed4 frag(v2f i) : SV_Target
			{
				return i.color;
			}
			ENDCG
        }
    }
    FallBack "Diffuse"
}
