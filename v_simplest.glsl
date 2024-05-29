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
out vec4 lfarg;
out vec4 nfarg;
out vec4 vfarg;
out vec2 iTexCoord0;


void main(void) {
    iC = colour;

    vec4  lp=vec4(0,0,-6,1);

    lfarg = V * lp - V * M * vertex; 
    nfarg = V * M * normals;
    vfarg = -V * M * vertex;

    iTexCoord0=texCoord0;

    gl_Position = P * V * M * vertex;
}
