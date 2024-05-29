#version 330

// Zmienne jednorodne
uniform mat4 P;
uniform mat4 V;
uniform mat4 M;
uniform float maxFurLength; // D�ugo�� futra
uniform float maxLayer; // Liczba rysowanych warstw

// Atrybuty
in vec4 vertex; // Wsp�rz�dne wierzcho�ka w przestrzeni modelu
in vec4 colour;
in vec4 normals;
in vec2 texCoord0;

// Zmienne interpolowane
out vec4 iC;
out vec4 lfrag;
out vec4 nfrag;
out vec4 vfrag;
out vec2 iTexCoord0;
out vec2 iTexCoord1;
out float layer; // Aktualna warstwa

void main(void) {
    // Przekazywanie koloru
    iC = colour;

    // Pozycja �wiat�a
    vec4 lp = vec4(0, 0, -6, 1);

    // Obliczanie wektora �wiat�a, normalnej i widoku
    lfrag = V * lp - V * M * vertex; 
    nfrag = V * M * normals;
    vfrag = -V * M * vertex;

    // Obliczanie wsp�rz�dnych teksturowania
    iTexCoord0 = texCoord0;
    vec4 n = normalize(nfrag);
    iTexCoord1 = (n.xy + 1) / 2;

    // Wyliczanie nowej wsp�rz�dnej wierzcho�ka dla konkretnej warstwy
    layer = float(gl_InstanceID); // Numer warstwy, to numer kopii
    vec4 nv = vertex + (layer * maxFurLength / maxLayer) * normalize(normals);

    // Obliczanie pozycji wierzcho�ka w przestrzeni clip
    gl_Position = P * V * M * nv;
}
