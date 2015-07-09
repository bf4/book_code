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

var exec = require('child_process').exec;

app.get('/:n?*', function (req, res) {
    if(!req.params.n) {
        res.send('Hello');
        return;
    }

    // Execute the separate calculation file
    var cmd = 'node fibonacci-calc.js ' + parseInt(req.params.n);
    exec(cmd, function (err, stdout, stderr) {
        //FIXME: We should handle possible errors here

        res.send('Fibonacci nr ' + req.params.n + ' is ' + parseInt(stdout));
    });

});

app.listen(3000);