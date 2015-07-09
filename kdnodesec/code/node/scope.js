/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
// a globally-scoped variable
var a = 1;

// global scope
function one(){
    alert(a);
}
one(); // Alerts 1

// local scope
function two(a){
    alert(a);
}
two(); // Alerts undefined

// local scope again
function three(){
    var a = 3;
    alert(a);
}
three(); // Alerts 3

// Intermediate: no such thing as block scope in javascript
function four(){
    if(true){
        var a=4;
    }

    alert(a); // alerts '4', not the global value of '1'
}
four(); // Alerts 4


// Intermediate: object properties
function Five(){
    this.a = 5;
}


// Advanced: closure
var six = function(){
    var foo = 6;

    return function(){
        // javascript "closure" means I have access to foo in here,
        // because it is defined in the function in which I was defined.
        alert(foo);
    }
}();


// Advanced: prototype-based scope resolution
function Seven(){
    this.a = 7;
}

// [object].prototype.property loses to [object].property in the lookup chain

// won't get reached, because 'a' is set in the constructor above.
Seven.prototype.a = -1;

// Will get reached, even though 'b' is NOT set in the constructor.
Seven.prototype.b = 8;