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
var crypto = require('crypto');

app.get('/getfile', function (req, res) {
    var stream = fs.createReadStream('./dictionary.txt', 'utf8');
    var hash = crypto.createHash('md5');

    //FIXME: Add error handling
    stream.on('data', function (data) {
        hash.update(data);
    });

    stream.on('end', function () {
        res.send(hash.digest('hex'));
    });
});

app.listen(3000);