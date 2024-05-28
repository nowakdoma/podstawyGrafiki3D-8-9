#version 330

in vec4 iC;
in vec4 lfarg;
in vec4 nfarg;
in vec4 vfarg;

out vec4 pixelColor; //Zmienna wyjsciowa fragment shadera. Zapisuje sie do niej ostateczny (prawie) kolor piksela

float limitValues(float value, float step) {
    return floor(value / step + 0.5) * step;
}

void main(void) {
    vec4 n = normalize(nfarg);
    vec4 l = normalize(lfarg);
    vec4 v = normalize(vfarg);

    float nl = max(dot(n, l), 0.0);
    nl = limitValues(nl, 0.25);

    vec4 La = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 Ld = vec4(1.0, 1.0, 1.0, 1.0);

    vec4 r = normalize(reflect(-l, n));

    float rv = max(dot(r, v), 0.0);
    rv = pow(rv, 25.0);
    rv = limitValues(rv, 0.25);

    vec4 Ls = vec4(1.0, 1.0, 1.0, 1.0); 
    vec4 ks = vec4(1.0, 1.0, 1.0, 1.0); 

    pixelColor = (Ld * iC * nl) + (Ls * ks * rv);
}
