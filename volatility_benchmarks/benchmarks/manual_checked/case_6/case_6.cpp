#include <stdlib.h>
#include <stdio.h>

// 2.3.
// Source:volatile
// Sink: Not volatile

int* a(int* arr) {
    return &arr[1]; //Sink
}

int* b(int* arr) {
    return &arr[2]; //sink
}
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
    int* (*funcs[2])(int*) = {a,b};
    int* ptr=funcs[rand() % 2](arr);
    ptr = &arr[0] + 5; //Source
    int x = *ptr;
}
