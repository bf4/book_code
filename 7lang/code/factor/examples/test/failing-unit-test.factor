! START:full
USING: examples.greeter tools.test ;
IN: examples.failing-unit-test

{ "Hello World" } [ "world" greeting ] unit-test
! END:full

