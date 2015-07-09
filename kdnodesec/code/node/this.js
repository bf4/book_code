/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/

// will print the global scope
// (in browsers this will be the window object, in node the global)
console.log(this);

var myFunction = function() {
    console.log(this);
};

myFunction(); //outputs window/global object

var newObject = {
    myFunction: myFunction
};

newObject.myFunction(); //outputs newObject
myFunction.call(newObject); // will print newObject
