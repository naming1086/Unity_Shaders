using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[ExecuteInEditMode]
public class Clouds : MonoBehaviour
{
    public Shader _cloudShader;
    public float MinHeight = 0.0f;
    public float MaxHeight = 5.0f;
    public float FadeDistance = 2f;
    public float Scale = 5f;
    public float Steps = 50;
    public Texture ValueNoiseImage;
    public Transform SunPos;
    private Camera _camera;
    private Material _Material;

    public Material Material
    {
        get
        {
            if (Material == null && _cloudShader != null)
            {
                _Material = new Material(_cloudShader);
            }

            if (_Material != null && _cloudShader == null)
            {
                DestroyImmediate(_Material);
            }

            if (_Material != null && _cloudShader != null && _cloudShader != _Material.shader)
            {
                DestroyImmediate(_Material);
                _Material = new Material(_cloudShader);
            }

            return _Material;
        }
    }

    private void Start()
    {
        if(_Material)
            DestroyImmediate(_Material);
    }

    Matrix4x4 GetFrustrumCorners()
    {
        Matrix4x4 frustrumCorners = Matrix4x4.identity;
        Vector3[] fCorners = new Vector3[4];
        
        _camera.CalculateFrustumCorners(new Rect(0,0,1,1),_camera.farClipPlane, Camera.MonoOrStereoscopicEye.Mono, fCorners);
        frustrumCorners.SetRow(0, fCorners[1]);
        frustrumCorners.SetRow(1, fCorners[2]);
        frustrumCorners.SetRow(2, fCorners[3]);
        frustrumCorners.SetRow(3, fCorners[0]);
        return frustrumCorners;
    }

}


