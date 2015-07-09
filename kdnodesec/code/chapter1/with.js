/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
var one = { two: { three: { four: { five: 1 } } } } // Lets declare some deep object

with(one.two.three.four) {
    five = 5;
}

console.log(one.two.three.four.five); // Will print 5

with(one.two.three.four) {
    five = "five";
    six = "six";
}

console.log(one.two.three.four.five); // Will print "five"
console.log(one.two.three.four.six); // Will print undefined
console.log(six); // will print "six"
