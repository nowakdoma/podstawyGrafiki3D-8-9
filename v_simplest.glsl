#version 330

//Zmienne jednorodne
uniform mat4 P;
uniform mat4 V;
uniform mat4 M;

//Atrybuty
in vec4 vertex; //wspolrzedne wierzcholka w przestrzeni modelu
in vec4 colour;

out vec4 iC;


void main(void) {
    gl_Position=P*V*M*vertex;
    iC = vertex;
}
