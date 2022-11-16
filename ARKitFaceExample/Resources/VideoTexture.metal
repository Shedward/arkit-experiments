//
//  VideoTexture.metal
//  ARKitFaceExample
//
//  Created by Vladislav Maltsev on 15.11.2022.
//  Copyright © 2022 Apple. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct PlaneNodeBuffer {
    float4x4 modelTransform;
    float4x4 modelViewTransform;
    float4x4 normalTransform;
    float4x4 modelViewProjectionTransform;
    float2x3 boundingBox;
};

struct VertexInput {
    float3      position         [[ attribute(SCNVertexSemanticPosition) ]];
    float2      texCoordinates   [[ attribute(SCNVertexSemanticTexcoord0) ]];
};

struct VertexOutput {
    float4      position         [[ position ]];
    float2      texCoordinates;
};

vertex VertexOutput VideoTextureVertex(
    VertexInput                 in                  [[ stage_in ]],
    constant SCNSceneBuffer&    scn_frame           [[ buffer(0) ]],
    constant PlaneNodeBuffer&   scn_node            [[ buffer(1) ]],
    constant float4x4&          displayTransform    [[ buffer(2) ]]
) {
    float4 vertexCamera = scn_node.modelViewTransform * float4(in.position, 1.0);
    float4 vertexClipSpace = scn_frame.projectionTransform * vertexCamera;
    vertexClipSpace /= vertexClipSpace.w;

    float4 vertexImageSpace = float4(vertexClipSpace.xy * 0.5 + 0.5, 0.0, 1.0);
    vertexImageSpace.y = 1.0 - vertexImageSpace.y;

    float4 texCoordinates = displayTransform * vertexImageSpace;

    VertexOutput vert;
    vert.position = scn_node.modelViewProjectionTransform * float4(in.position, 1.0);
    vert.texCoordinates = texCoordinates.xy;
    return vert;
}

fragment half4 VideoTextureFragment(
    VertexOutput                        vert            [[ stage_in ]],
    texture2d<float, access::sample>    diffuseTexture  [[ texture(0) ]]
) {
    constexpr sampler sampler2d(coord::normalized, filter::linear, address::repeat);
    float4 color = diffuseTexture.sample(sampler2d, vert.texCoordinates);
    return half4(color);
}
