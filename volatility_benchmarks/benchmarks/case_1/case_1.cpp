#include <stdio.h>
void foo(int* a){
	int y = *a;
}

int main(){
    int a = 0;
    int b = 1;
    int* arr[] = {&a, &b};
    for(int i = 0; i < 100; ++i){
        foo(arr[i%2]);
    }
}