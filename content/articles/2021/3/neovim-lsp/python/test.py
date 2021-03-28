#!/usr/bin/env python3

def fizz_buzz(num: int) -> str:
    if num % 15 == 0:
        return "FizzBuzz"
    if num % 3  == 0:
        return "Fizz"
    if num % 5 == 0:
        return "Buzz"

    return str(num)

def fizz_buzz_it(limit: int) -> None:
    for i in range(0, limit):
        print(fizz_buzz(i))

if __name__ == "__main__":
    fizz_buzz_it(100)

