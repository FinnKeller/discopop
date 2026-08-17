#include <stdio.h>

// 2.1.
// Quelle: Nicht volatile
// Ziel: Nicht volatile

int main(){
    int arr[] = {0,1,2,3,4,5,6,7,8,9}; //Ziel
    int* ptr = &arr[0];
    ptr = ptr + 5;
    int x = *ptr; //Quelle
}
