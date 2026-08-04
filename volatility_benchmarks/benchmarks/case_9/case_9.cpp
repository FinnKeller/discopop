#include <stdio.h>
#include <stdlib.h>
int main(){
    int arr[10] = {0,1,2,3,4,5,6,7,8,9};
    int* ptr = &arr[0];
    int x = 0;

    for(int i = 0; i < 15; i++){
        ptr = &arr[0] + (rand() % 10);
        x = *ptr;
    }
}