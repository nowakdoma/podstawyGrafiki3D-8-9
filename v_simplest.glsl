#version 330

//Zmienne jednorodne
uniform mat4 P;
uniform mat4 V;
uniform mat4 M;

//Atrybuty
in vec4 vertex; //wspolrzedne wierzcholka w przestrzeni modelu
in vec4 colour;
in vec4 normals;

out vec4 iC;
out vec4 lfarg;
out vec4 nfarg;
out vec4 vfarg;

void main(void) {
    iC = colour;

    vec4  lp=vec4(0,0,-6,1);

    lfarg = V * lp - V * M * vertex; 
    nfarg = V * M * normals;
    vfarg = -V * M * vertex;

    gl_Position = P * V * M * vertex;
}
