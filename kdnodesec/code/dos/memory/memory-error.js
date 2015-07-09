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

var fs = require('fs');

app.get('/getfile', function (req, res) {
    fs.readFile('./dictionary.txt', 'utf8', function (err, content) {
        res.send(err ? 500 : content); // send an error or content of file
    });
});

app.listen(3000);