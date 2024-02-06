Shader "EKKA/VRChat/HUD"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Cutoff ("Alpha Cutoff", Range(0,1)) = 0.5
    }

    SubShader
    {
        Tags {"Queue"="Overlay" "RenderType"="Overlay" "IgnoreProjector"="True" "IsEmissive" = "true"}
        Cull Back
        ZWrite Off
        ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha

        CGPROGRAM
        #include "UnityCG.cginc"
        #pragma surface surf Unlit alphatest:_Cutoff
        #pragma target 3.0

        inline fixed4 LightingUnlit (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            return fixed4(s.Albedo, s.Alpha);
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        uniform sampler2D _MainTex;
        uniform half4 _Color;
        uniform float _VRChatCameraMode;
        uniform float _VRChatMirrorMode;

        void surf(Input i, inout SurfaceOutput o)
        {
            half4 c = tex2D(_MainTex, i.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = _VRChatCameraMode > 0 ? 0 : (_VRChatMirrorMode > 0 ? 0 : c.a);
        }
        ENDCG
    }
}