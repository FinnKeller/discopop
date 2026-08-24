#include <stdio.h>

// 1.1.
// Source: Nicht volatile
// Sink: Nicht volatile

int main(){
    int a = 0;
    int* p = &a; //Sink
    int x = 0;
    x = *p; //Source
}
