#version 330

// Zmienne jednorodne
uniform mat4 P;
uniform mat4 V;
uniform mat4 M;
uniform float maxFurLength; // D³ugoœæ futra
uniform float maxLayer; // Liczba rysowanych warstw

// Atrybuty
in vec4 vertex; // Wspó³rzêdne wierzcho³ka w przestrzeni modelu
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
    iC = colour;

    vec4 lp = vec4(0, 0, -6, 1);

    lfrag = V * lp - V * M * vertex; 
    nfrag = V * M * normals;
    vfrag = -V * M * vertex;

    iTexCoord0 = texCoord0;
    vec4 n = normalize(nfrag);
    iTexCoord1 = (n.xy + 1) / 2;

    layer = float(gl_InstanceID); // Numer warstwy, to numer kopii
    vec4 nv = vertex + (layer * maxFurLength / maxLayer) * normalize(normals);

    vec4 vGravity=vec4(0,-0.08,0,0);
    vGravity=inverse(M)*vGravity;
    nv=nv+vGravity*pow(layer/maxLayer,2);

    gl_Position = P * V * M * nv;
}
