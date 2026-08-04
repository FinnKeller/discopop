#include <stdlib.h>
#include <stdio.h>
int* func(){
	int arr[10] = {0,1,2,3,4,5,6,7,8,9};
	return &arr[0];
}
int main(){
	int* a = func();
	a = a + 5;
	int x = *a;
}