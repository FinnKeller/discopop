#include <stdio.h>
#include <stdlib.h>

void bar(int *p) {
    *p = 42;
}

void foobar(int *p) {
    *p = 12;
}

int main() {
    int a = 0;
    int *ptr = &a;

    void (*funcs[2])(int *) = {bar, foobar};

    funcs[rand() % 2](ptr);

    int x = *ptr;
}