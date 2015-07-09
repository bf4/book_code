/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/

// define the Person Class
function Person() {}

// Modify the prototype
Person.prototype.walk = function(){
    console.log('I am walking!');
};
Person.prototype.sayHello = function(){
    console.log('hello');
};
// now every Person object will be able to invoke these functions

var person = new Person();

person.walk(); // will log 'I am walking!'

var person2 = new Person();

person2.__proto__.walk = function () {
    console.log('I am fast walking');
};

person2.walk(); // logs 'I am fast walking'

person.walk(); // also logs 'I am fast walking' since we changed the prototype

// Lets change the Array prototype
Array.prototype.join = function () {
    return 'I am Johnson';
};

var a = ['a', 'b'];
a.join(','); // Will return 'I am Johnson' instead of the expected 'a,b'
