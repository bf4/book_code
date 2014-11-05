! START:full
USE: io
! START:init
USE: examples.greeter
IN: examples.hello

: hello-world ( -- ) "world" greeting print ;

MAIN: hello-world
! END:init
! END:full
