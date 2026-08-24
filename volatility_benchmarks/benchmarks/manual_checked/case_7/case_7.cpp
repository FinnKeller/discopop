#include <stdio.h>
#include <stdlib.h>
// 2.4.
// Source: volatile
// Sink: volatile
int foo(int* ptr){
    return *ptr;  // Sink
}

int bar(int* ptr){
    return *ptr; // Sink
}
int* a(int* arr) { return &arr[1];}
int* b(int* arr) { return &arr[2]; }

int main(){
 	int arr[10];
 	arr[0] = 0;
 	arr[1] = 1;
 	arr[2] = 2;
 	arr[3] = 3;
 	arr[4] = 4;
 	arr[5] = 5;
 	arr[6] = 6;
 	arr[7] = 7;
 	arr[8] = 8;
 	arr[9] = 9;
 	int* (*funcs[2])(int*) = { a, b };
 	int* ptr = funcs[rand() % 2](arr); //Source
 	ptr = ptr + (rand() % 5);

 	int (*read_funcs[2])(int*) = { foo, bar };
 	int x = read_funcs[rand() % 2](ptr);
}
