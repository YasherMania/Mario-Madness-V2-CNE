// so retro - apurples

#pragma header
uniform vec2 uBlocksize;

void main()
{
    vec2 blocks = openfl_TextureSize / uBlocksize;
    vec2 uv = openfl_TextureCoordv;
    uv -= vec2(0.5);
    uv = floor(uv * blocks) / blocks;
    uv += vec2(0.5);
    gl_FragColor = flixel_texture2D(bitmap, uv);
}