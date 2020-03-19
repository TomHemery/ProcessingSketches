varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
uniform float u_colorFactor;

void main()
{
	vec4 sample =  texture2D(CC_Texture0, v_texCoord);
	float grey = 0.21 * sample.r + 0.71 * sample.g + 0.07 * sample.b;
	gl_FragColor = vec4(sample.r * u_colorFactor + grey * (1.0 - u_colorFactor), sample.g * u_colorFactor + grey * (1.0 - u_colorFactor), sample.b * u_colorFactor + grey * (1.0 - u_colorFactor), 1.0);
}	
