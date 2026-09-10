#include <stdio.h>
#include <stdlib.h>

// 1.3.
// Source:  volatile
// Sink: Nicht volatile

void bar(int* p){
 	*p = 42; // Sink
}
void foobar(int* p){
 	*p = 12; // Sink
}

int main(){
 	int a = 0;
 	int* ptr = &a;
 	void (*funcs[2])(int*) = { bar, foobar };
 	funcs[rand() % 2](ptr); //Source
 	int x = *ptr;
}
