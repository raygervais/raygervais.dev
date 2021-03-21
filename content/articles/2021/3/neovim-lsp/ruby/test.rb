# https://gist.github.com/Kerrick/2483510#gistcomment-277060

def fizzbuzz?(num)
  case
  when (num % 15).zero? then 'Fizzbuzz'
  when (num % 3).zero?  then 'Fizz'
  when (num % 5).zero?  then 'Buzz'
  else num
  end
end

def fizz_buzz_to(limit)
  1.upto(limit).each do |num|
    puts fizzbuzz?(num)
  end
end

fizz_buzz_to(100)
