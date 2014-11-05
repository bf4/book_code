! START:full
USING: kernel sequences ;
! START:init
IN: examples.greeter

: greeting ( name -- greeting ) "Hello, " swap append ;
! END:init
! END:full
