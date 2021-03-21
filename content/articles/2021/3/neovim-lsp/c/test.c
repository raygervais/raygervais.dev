#include<stdio.h>

void fizz_buzz(int num) {
    if (num % 15 == 0) {
        printf("FizzBuzz\n"); 
    } else if (num % 3 == 0) {
        printf("Fizz\n");
    } else if (num % 5 == 0) {
        printf("Buzz\n");
    } else {
        printf("%d\n", num);
    }

    return;
}

int main(void) {
    for (int i = 0; i <= 100; i++) {
        fizz_buzz(i);
    }

    return 0;
}
