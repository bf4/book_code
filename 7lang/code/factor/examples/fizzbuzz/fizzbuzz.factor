! START:traditional
USING: kernel io combinators.short-circuit math math.functions math.ranges
  present sequences ;

IN: examples.fizzbuzz

: fizzbuzz-traditional ( n -- seq )
    [1,b] [ ! (1)
    ! START:ifbranch
      dup 15 mod 0 =
      [ drop "FizzBuzz" ]
      [
    ! END:traditional
        ! ...
    ! START:traditional
    ! END:ifbranch
        dup 3 mod 0 = ! (2)
        [ drop "Fizz" ]
        [
          dup 5 mod 0 = ! (3)
          [ drop "Buzz" ]
          [ present ] ! (4)
          if
        ]
        if
    ! START:ifbranch
      ]
      if
    ! END:ifbranch
    ] map ; ! (5)
! END:traditional

! START:pipeline
: mult? ( x/str n -- ? ) over number? [ mod 0 = ] [ 2drop f ] if ; ! (6)

: when-mult ( x/str n str -- x/str ) pick [ mult? ] 2dip ? ; ! (7)

: fizz     ( x/str -- x/str )  3 "Fizz"     when-mult ; ! (8)
: buzz     ( x/str -- x/str )  5 "Buzz"     when-mult ;
: fizzbuzz ( x/str -- x/str ) 15 "FizzBuzz" when-mult ;

: fizzbuzz-pipeline ( x -- str ) fizzbuzz fizz buzz present ; ! (9)

: fizzbuzz-with-pipeline ( n -- seq ) [1,b] [ fizzbuzz-pipeline ] map ; ! (10)
! END:pipeline

