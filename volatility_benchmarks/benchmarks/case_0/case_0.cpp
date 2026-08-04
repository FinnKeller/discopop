#include <stdio.h>

int main(){
    int a = 0;
    int b = 1;
    int* p = &a;
    int* arr[] = {&a,&b};
    int x = 0;
    for(int i = 0; i < 10; i ++){
        p = arr[i%2];
        x = *p;
    }
}