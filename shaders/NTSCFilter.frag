#pragma header

// DECODE NTSC AND CRT EFFECTS

uniform float uFrame;
uniform float uScanlineEffect;

const float XRES = 54.0 * 8.0;
const float YRES = 33.0 * 8.0;

#define BRIGHTNESS 1.1
#define SATURATION 1.8
#define BLUR 0.7
#define BLURSIZE 0.2
#define CHROMABLUR 0.1
#define CHROMASIZE 5.0
#define SUBCARRIER 2.1
#define CROSSTALK 0.1
#define SCANFLICKER 0.2
#define INTERFERENCE1 1.0
#define INTERFERENCE2 0.01

const float fishEyeX = 0.1;
const float fishEyeY = 0.24;
const float vignetteRounding = 160.0;
const float vignetteSmoothness = 1.;

#define PI 3.14159265

// Fish-eye effect
vec2 fisheye(vec2 uv) {
	uv *= vec2(1.0+(uv.y*uv.y)*fishEyeX,1.0+(uv.x*uv.x)*fishEyeY);
	return uv;
}

float vignette(vec2 uv) {
	uv *= 2.0;
	float amount = 1.0 - sqrt(pow(abs(uv.x), vignetteRounding) + pow(abs(uv.y), vignetteRounding));
	float vhard = smoothstep(0., vignetteSmoothness, amount);
	return(vhard);
}

float hash12(vec2 p)
{
	vec3 p3 = fract(vec3(p.xyx) * .1031);
	p3 += dot(p3, p3.yzx + 33.33);
	return fract((p3.x + p3.y) * p3.z);
}

float random(vec2 p, float t) {
	return hash12((p * 0.152 + t * 1500. + 50.0));
}

float peak(float x, float xpos, float scale) {
	return clamp((1.0 - x) * scale * log(1.0 / abs(x - xpos)), 0.0, 1.0);
}

void main() {
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 fragCoord = uv * openfl_TextureSize.xy;

	float scany = floor(uv.y * YRES + 0.5);

	uv -= 0.5;
	uv = fisheye(uv);
	float vign = vignette(uv);
	uv += 0.5;
	uv.y += 1.0 / YRES * SCANFLICKER;

	// interference
	float r = random(vec2(0.0, scany), uFrame/60.);
	if (r > 0.99) {r *= 3.0;}
	float ifx1 = INTERFERENCE1 * 2.0 / openfl_TextureSize.x * r;
	float ifx2 = INTERFERENCE2 * (r * peak(uv.y, 0.2, 0.2));
	uv.x += ifx1 + -ifx2;

	vec4 out_color = texture2D(bitmap, uv);

	float scanl = 0.5 + 0.5 * abs(sin(PI * uv.y * YRES));

	vec3 rgb = vign * out_color.rgb;
	gl_FragColor = vec4(mix(rgb, rgb * scanl, uScanlineEffect), out_color.a);
}