#pragma header

uniform float iTime;
uniform float strengthMulti;
uniform float imtoolazytonamethis;

const float maxStrength = .8;
const float minStrength = 0.3;

const float speed = 20.00;

float random (vec2 noise)
{
	return fract(sin(dot(noise.xy,vec2(10.998,98.233)))*12433.14159265359);
}

void main()
{
		
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 uv2 = fract(openfl_TextureCoordv.xy*fract(sin(iTime*speed)));
		
	float _maxStrength = clamp(sin(iTime/2.0),minStrength+imtoolazytonamethis,maxStrength) * strengthMulti;
		
	vec3 colour = vec3(random(uv2.xy) - 0.1)*_maxStrength;
	vec3 background = vec3(flixel_texture2D(bitmap, uv));
		
	gl_FragColor = vec4(background-colour,1.0);
}