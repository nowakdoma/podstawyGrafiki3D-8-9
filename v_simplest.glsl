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


void main(void) {

    vec4  lp=vec4(0,0,-6,1);

    vec4 l = normalize(V * lp - V * M * vertex);
    vec4 n = normalize(V * M * normals);

    float nl = max(dot(n, l), 0.0);

    vec4 La = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 Ld = vec4(1.0, 1.0, 1.0, 1.0);

    iC = Ld * colour * nl;
 
    gl_Position = P * V * M * vertex;
}
