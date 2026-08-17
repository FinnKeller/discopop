#include <stdlib.h>
#include <stdio.h>
// 2.2.

int main(){
   int arr[10]; //Ziel
   arr[0] = 0;
   arr[1] = 1;
   arr[2] = 2;
   arr[3] = 3;
   arr[4] = 4;
   arr[5] = 5;
   arr[6] = 6;
   arr[7] = 7;
   arr[8] = 8;
   arr[9] = 9;
   int* ptr = &arr[0]; 
   ptr = ptr + (rand() % 10);
   int x = *ptr; //Quelle
   }
