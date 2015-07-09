/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var express = require('express');
var app = express();

// Calculating fibonacci number recursively
function fibonacci(n) {
    if(n < 3) {
        return 1;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

app.get('/:n?*', function (req, res) {
    if(!req.params.n) {
        res.send('Hello');
        return;
    }
    var fib = fibonacci(+req.params.n);
    res.send('Fibonacci nr ' + req.params.n + ' is ' + fib);
});

app.listen(3000);