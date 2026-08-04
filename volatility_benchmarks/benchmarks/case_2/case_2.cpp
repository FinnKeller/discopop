#include <stdio.h>
#include <stdlib.h>

int main(){
    int a = 0;
    int b = 1;
    int* p = &a;
    int* arr[] = {&a,&b};
    int x = 0;
    int ran = 0;
    for(int i = 0; i < 10; i ++){
        ran = rand() % 2;
        p = arr[ran];
        x = *p;
    }
}