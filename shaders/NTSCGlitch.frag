#pragma header
uniform float time;
uniform vec2 resolution;

uniform float glitchAmount;

#define PI 3.14159265

vec4 tex2D( sampler2D _tex, vec2 _p ){
    vec4 col = texture2D( _tex, _p );
    if ( 0.5 < abs( _p.x - 0.5 ) ) {
        col = vec4( 0.1 );
    }
    return col;
}

float hash( vec2 _v ){
    return fract( sin( dot( _v, vec2( 89.44, 19.36 ) ) ) * 22189.22 );
}

float iHash( vec2 _v, vec2 _r ){
    float h00 = hash( vec2( floor( _v * _r + vec2( 0.0, 0.0 ) ) / _r ) );
    float h10 = hash( vec2( floor( _v * _r + vec2( 1.0, 0.0 ) ) / _r ) );
    float h01 = hash( vec2( floor( _v * _r + vec2( 0.0, 1.0 ) ) / _r ) );
    float h11 = hash( vec2( floor( _v * _r + vec2( 1.0, 1.0 ) ) / _r ) );
    vec2 ip = vec2( smoothstep( vec2( 0.0, 0.0 ), vec2( 1.0, 1.0 ), mod( _v*_r, 1. ) ) );
    return ( h00 * ( 1. - ip.x ) + h10 * ip.x ) * ( 1. - ip.y ) + ( h01 * ( 1. - ip.x ) + h11 * ip.x ) * ip.y;
}

float noise( vec2 _v ){
    float sum = 0.;
    for( int i=1; i<9; i++ )
    {
        sum += iHash( _v + vec2( i ), vec2( 2. * pow( 2., float( i ) ) ) ) / pow( 2., float( i ) );
    }
    return sum;
}

void main(){
    vec2 uvn = openfl_TextureCoordv.xy;

    // tape wave
    uvn.x += ( noise( vec2( uvn.y, time ) ) - 0.5 )* 0.002;
    uvn.x += ( noise( vec2( uvn.y * 100.0, time * 10.0 ) ) - 0.5 ) * (0.01*glitchAmount);

    vec4 col = tex2D( bitmap, uvn );

    col *= 1.0 + clamp( noise( vec2( 0.0, uvn.y + time * 0.2 ) ) * 0.6 - 0.25, 0.0, 0.1 );

    gl_FragColor = col;
}