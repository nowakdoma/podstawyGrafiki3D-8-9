#version 330

in vec4 iC;
in vec4 lfrag;
in vec4 nfrag;
in vec4 vfrag;
in vec2 iTexCoord0;
in vec2 iTexCoord1;
in float layer; // Aktualna warstwa

out vec4 pixelColor;

uniform sampler2D textureMap0;
uniform sampler2D textureMap1; // Druga tekstura

void main(void) {
    // Pobranie kolor�w z dw�ch tekstur
    vec4 fur = texture(textureMap0, iTexCoord0); // Tekstura futra
    vec4 furCol = texture(textureMap1, iTexCoord0); // Kolor futra

    vec4 col = furCol; // Domy�lny kolor

    // Je�eli nie pierwsza warstwa, dodaj alfa z tekstury futra
    if (layer != 0)
        col = vec4(furCol.rgb, fur.a);

    // Usuni�cie niewidocznego fragmentu (z zachowaniem warto�ci w buforze)
    if (fur.a == 0 && layer != 0)
        discard;

    // Obliczenie ostatecznego koloru piksela ze �wiat�em rozproszonym
    vec4 n = normalize(nfrag);
    vec4 l = normalize(lfrag);
    float nl = max(dot(n, l), 0.0);
    pixelColor = col * vec4(nl, nl, nl, 1); // Wynikowy kolor piksela
}
