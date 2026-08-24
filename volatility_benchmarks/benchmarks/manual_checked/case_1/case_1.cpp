#include <stdio.h>
#include <stdlib.h>

// 1.2.
// Source: Nicht volatile
// Sink: volatile

int main(){
    int a = 0; //Sink
    int b = 1; //Sink
    int* p = &a; 
    int* arr[] = {&a,&b};
    int x = 0;
    int ran = 0;
    ran = rand() % 2;
    p = arr[ran];
    x = *p; //Source
}
