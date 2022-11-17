

#pragma transparent
#pragma body

// grab uv coords from our material
float2 uv = _surface.diffuseTexcoord;
float width = u_diffuseTexture.get_width();
float height = u_diffuseTexture.get_width();
float xPixel = (1 / width) * 2;
float yPixel = (1 / height) * 2;

float3 sum = float3(0.0, 0.0, 0.0);

sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 4.0*xPixel, uv.y - 4.0*yPixel)).rgb * 0.0162162162;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 3.0*xPixel, uv.y - 3.0*yPixel)).rgb * 0.0540540541;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 2.0*xPixel, uv.y - 2.0*yPixel)).rgb * 0.1216216216;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 1.0*xPixel, uv.y - 1.0*yPixel)).rgb * 0.1945945946;

sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 4.0*xPixel, uv.y - 1.0*yPixel)).rgb * 0.0162162162;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 3.0*xPixel, uv.y - 2.0*yPixel)).rgb * 0.0540540541;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 2.0*xPixel, uv.y - 3.0*yPixel)).rgb * 0.1216216216;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x - 1.0*xPixel, uv.y - 4.0*yPixel)).rgb * 0.1945945946;

sum += u_diffuseTexture.sample(u_diffuseTextureSampler, uv).rgb * 0.2270270270 * 2.0;

sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 1.0*xPixel, uv.y + 4.0*yPixel)).rgb * 0.1945945946;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 2.0*xPixel, uv.y + 3.0*yPixel)).rgb * 0.1216216216;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 3.0*xPixel, uv.y + 2.0*yPixel)).rgb * 0.0540540541;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 4.0*xPixel, uv.y + 1.0*yPixel)).rgb * 0.0162162162;

sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 1.0*xPixel, uv.y + 1.0*yPixel)).rgb * 0.1945945946;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 2.0*xPixel, uv.y + 2.0*yPixel)).rgb * 0.1216216216;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 3.0*xPixel, uv.y + 3.0*yPixel)).rgb * 0.0540540541;
sum += u_diffuseTexture.sample(u_diffuseTextureSampler, float2(uv.x + 4.0*xPixel, uv.y + 4.0*yPixel)).rgb * 0.0162162162;

float4 adjusted;
adjusted.rgb = sum / 2;
adjusted.b += 0.07;
adjusted.a = 1.0;

_output.color.rgba = adjusted;
