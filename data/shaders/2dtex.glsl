uniform mat4 uMvpMatrix;
uniform sampler2D uTexture0;
uniform lowp vec4 uColor;
uniform vec2 uTexOffset0;
uniform vec2 uTexScale0;

varying vec4 vColor;
varying vec2 vTexCoord;

#ifdef VERTEX
attribute vec4 aPosition;
attribute vec2 aTexCoord;

void main(void)
{
	vTexCoord = aTexCoord * uTexScale0 + uTexOffset0;
	gl_Position = uMvpMatrix * vec4(aPosition.xy, 0.0, 1.0);
}
#endif

#ifdef FRAGMENT
void main(void) 
{
	vec4 texColor = texture2D(uTexture0, vTexCoord);
	gl_FragColor = texColor * uColor;
}
#endif

