package main

import (
	"fmt"
	"strconv"
)

func fizzBuzz(num int) string {

	if num%15 == 0 {
		return "FizzBuzz"
	}

	if num%3 == 0 {
		return "Fizz"
	}

	if num%5 == 0 {
		return "Buzz"
	}

	return strconv.Itoa(num)
}

func main() {
	for i := 0; i < 100; i++ {
		fmt.Println(fizzBuzz(i))
	}
}
