/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
var i = 0;

function iteratorHandler() {
    i = 10;
}

function iterate() {
    //this iteration will only run once
    for (i = 0; i < 10; i++) { // Since we don't use var here the global i is used

        console.log(i); //outputs 0
        iteratorHandler();
        console.log(i); //outputs 10

    }
}

iterate();