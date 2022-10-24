Shader "Unlit/CharacterShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Stress("Stress", Range(0.0, 1.0)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _Stress;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                float t = atan(v.vertex.y/v.vertex.x);
                float f1 = 1 + .2 * sin(10 * t + 10 * _Time);
                float f2 = 1 + _Stress * .5 * sin(20 * t + 20 * _Time);
                v.vertex.xy = v.vertex.xy * f1 * f2;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
