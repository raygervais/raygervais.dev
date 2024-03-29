fn main() {
    for i in 1..101 {
        fizz_buzz(i);
    } 
}

 fn fizz_buzz(i: i32) {
    match (i % 3, i % 5) {
        (0, 0) => println!("FizzBuzz"),
        (0, _) => println!("Fizz"),
        (_, 0) => println!("Buzz"),
        _ => println!("{}", i),
    };
}
