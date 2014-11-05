! START:test
USING: examples.fizzbuzz tools.test ;

IN: examples.fizzbuzz.tests

CONSTANT: fizzbuzz-30 {
  { "1" "2" "Fizz" "4" "Buzz" "Fizz" "7" "8" "Fizz" "Buzz" "11" "Fizz" "13" "14"
  "FizzBuzz" "16" "17" "Fizz" "19" "Buzz" "Fizz" "22" "23" "Fizz" "Buzz" "26"
  "Fizz" "28" "29" "FizzBuzz" }
}

fizzbuzz-30 [ 30 fizzbuzz-traditional ] unit-test
! END:test
fizzbuzz-30 [ 30 fizzbuzz-with-pipeline ] unit-test
fizzbuzz-30 [ 30 fizzbuzz-with-short-circuit ] unit-test

