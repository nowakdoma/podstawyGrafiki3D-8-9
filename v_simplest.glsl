#version 330

//Zmienne jednorodne
uniform mat4 P;
uniform mat4 V;
uniform mat4 M;

//Atrybuty
in vec4 vertex; //wspolrzedne wierzcholka w przestrzeni modelu
in vec4 colour;
in vec4 normals;
in vec2 texCoord0;

out vec4 iC;
out vec4 lfrag;
out vec4 nfrag;
out vec4 vfrag;
out vec2 iTexCoord0;
out vec2 iTexCoord1;


void main(void) {
    iC = colour;

    vec4  lp=vec4(0,0,-6,1);

    lfrag = V * lp - V * M * vertex; 
    nfrag = V * M * normals;
    vfrag = -V * M * vertex;

    iTexCoord0=texCoord0;
    vec4 n = normalize(nfrag);
    iTexCoord1=(n.xy+1)/2;

    gl_Position = P * V * M * vertex;
}
