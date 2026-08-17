#include <stdio.h>
#include <stdlib.h>

// 1.4.
// Quelle: volatile
// Ziel: volatile

void bar(int** ptr, int* arr[]) {
 	*ptr = arr[0]; //Quelle
}
void foobar(int** ptr,int* arr[]) {
 	*ptr=arr[1]; //Quelle
}
int main() {
    int a = 0;
    int b = 1;
    int* ptr = &a;
    int* arr[2] = { &a, &b };
    void (*funcs[2])(int**,int*[]) = {bar,foobar};
    funcs[rand()%2](&ptr,arr);
    int x = *ptr;
}
