#include <stdio.h>
#include <stdlib.h>

// 1.3.
// Quelle:  volatile
// Ziel:Nicht volatile

void bar(int* p){
 	*p = 42; // Ziel
}
void foobar(int* p){
 	*p = 12; //Ziel
}

int main(){
 	int a = 0;
 	int* ptr = &a;
 	void (*funcs[2])(int*) = { bar, foobar };
 	funcs[rand() % 2](ptr); //Quelle
 	int x = *ptr;
}
