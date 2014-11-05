USING: accessors kernel math syntax tools.test examples.tuples ;

IN: examples.tuples.tests

{ T{ cart-item f f f f } } [
! START:new
cart-item new
! END:new
] unit-test

{ T{ cart-item f "Seven Languages Book" 25.00 1 } }
[
! START:boa
"Seven Languages Book" 25.00 1 cart-item boa
! END:boa
] unit-test

{ T{ cart-item f "Paint brush" 1.00 1 } }
[
! START:partial_boa
"Paint brush" <dollar-cart-item>
! END:partial_boa
] unit-test

{ T{ cart-item f f 4.95 f } } [
! START:accessors
cart-item new 4.95 >>price
! END:accessors
] unit-test

! Results in 4.95 on the stack.
{ 4.95 } [
! START:accessors
cart-item new 4.95 >>price price>>
! END:accessors
] unit-test

{ T{ cart-item f f 12.50 f } } [
! START:manual_change
cart-item new 25.00 >>price 
dup price>> 0.5 * >>price
! END:manual_change
] unit-test

{ T{ cart-item f f 12.50 f } } [
! START:auto_change
cart-item new 25.00 >>price
[ 0.5 * ] change-price
! END:auto_change
] unit-test

{ 1 }
[ <one-cart-item> quantity>> ]
unit-test

{ T{ cart-item f "orange" 0.59 f } }
[
! START:t_boa
T{ cart-item f "orange" 0.59 }
! END:t_boa
]
unit-test

