! START:init
USING: tools.test io io.streams.null kernel namespaces sequences ;

! END: init
USE: examples.checkout
USE: examples.fizzbuzz
! START:init
USE: examples.greeter ! (1)
! END: init
USE: examples.tuples
! START:init

IN: examples.test-suite

: test-all-examples ( -- )
    [ "examples" test ] with-null-writer ! (2)
    test-failures get empty? ! (3)
    [ "All tests passed." print ] [ :test-failures ] if ; ! (4)

MAIN: test-all-examples
! END: init

