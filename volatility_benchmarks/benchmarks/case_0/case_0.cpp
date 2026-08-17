#include <stdio.h>

// 1.1.
// Quelle: Nicht volatile
// Ziel: Nicht volatile

int main(){
    int a = 0;
    int* p = &a; //Ziel
    int x = 0;
    x = *p; //Quelle
}
