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

// Non blocking fibonacci recursive
function fibonacci(n, cb) {
    if(n < 3) {
        // return the number in the callback
        cb(1);
        return;
    }

    var sum = 0;
    function end(subN) {
        if(sum !== 0) {
            cb(sum + subN);
        } else {
            sum += subN;
        }
    }
    // Start calculation of previous two numbers
    fibonacci(n - 1, end);
    fibonacci(n - 2, end);
}

app.get('/:n?*', function (req, res) {
    if(!req.params.n) {
        res.send('Hello');
        return;
    }

    // Execute the separate calculation file
    fibonacci(+req.params.n, function (result) {
        res.send('Fibonacci nr ' + req.params.n + ' is ' + result);
    })

});

app.listen(3000);