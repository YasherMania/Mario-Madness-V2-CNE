#pragma header

uniform vec3 uHsv; // [h, s, v]

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);

    vec3 swagColor = rgb2hsv(color.rgb);

    swagColor.xy += uHsv.xy;
    swagColor[2] = swagColor[2] * (1.0 + uHsv[2]);

    swagColor[1] = clamp(swagColor[1], 0.0, 1.0);

    gl_FragColor = vec4(hsv2rgb(swagColor), color.a);
}