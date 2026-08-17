#include <stdio.h>
#include <stdlib.h>

// 1.2.
// Quelle: Nicht volatile
// Ziel: volatile

int main(){
    int a = 0; //Ziel
    int b = 1; //Ziel
    int* p = &a; 
    int* arr[] = {&a,&b};
    int x = 0;
    int ran = 0;
    ran = rand() % 2;
    p = arr[ran];
    x = *p; //Quelle
}
