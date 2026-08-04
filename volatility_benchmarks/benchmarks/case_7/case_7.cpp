#include <stdio.h>
#include <stdlib.h>

int* func(){
	int a = rand();
	int* ptr = &a;
	ptr = &a;
}
int main(){
	int* a = func();
	a = a + rand();
	int x = *a;

}