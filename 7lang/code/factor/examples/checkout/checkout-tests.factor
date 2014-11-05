USING: examples.checkout tools.test arrays ;

IN: examples.checkout.tests

{ 49.98 } [ "7lang2" 24.99 2 <cart-item> cart-item-price ] unit-test

! START:sample_test
: <sample-cart> ( -- cart ) 
  "7lang2" 24.99 2 <cart-item> "noderw" 10.99 1 <cart-item> 2array ;

! END:sample_test
{ 60.97 } [ <sample-cart> cart-base-price ] unit-test
{ 3 } [ <sample-cart> cart-item-count ] unit-test

{ T{ checkout f 3 60.97 f f f } }
[ <sample-cart> <checkout> ]
unit-test

! START:sample_test
{ T{ checkout f 3 60.97 9.13 4.49 74.59 } }
[ <sample-cart> <checkout> sample-checkout ]
unit-test
! END:sample_test

