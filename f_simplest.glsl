#version 330

in vec4 iC;
in vec4 lfrag;
in vec4 nfrag;
in vec4 vfrag;
in vec2 iTexCoord0;
in vec2 iTexCoord1; 

out vec4 pixelColor;

uniform sampler2D textureMap0;
uniform sampler2D textureMap1; // Druga tekstura

void main(void) {
    vec4 n = normalize(nfrag);
    vec4 l = normalize(lfrag);
    vec4 v = normalize(vfrag);

    float nl = max(dot(n, l), 0.0);

    vec4 La = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 Ld = vec4(1.0, 1.0, 1.0, 1.0);

    vec4 r = normalize(reflect(-l, n));

    float rv = max(dot(r, v), 0.0);
    rv = pow(rv, 25.0);

    vec4 texColor0 = texture(textureMap0, iTexCoord0);
    vec4 texColor1 = texture(textureMap1, iTexCoord1); 

    vec4 kd = mix(texColor0, texColor1, 0.3); 
    vec4 ks = vec4(1.0, 1.0, 1.0, 1.0); 

    vec4 Ls = vec4(1.0, 1.0, 1.0, 1.0);

    // Finalny kolor piksela
    pixelColor = (Ld * kd * nl) + (Ls * ks * rv);
}
