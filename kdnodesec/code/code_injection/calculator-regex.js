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
var bodyParser = require('body-parser');
var app = express();

app.use(bodyParser.urlencoded());

app.get('/', function(req, res){
    var form = '' +
        '<form method="POST" action="/calc">' +
        '<input type="text" name="formula" placeholder="formula" />' +
        '<input type="submit" value="Calculate" />' +
        '</form>';
    res.send(form);
});

app.post('/calc', function (req, res) {
    var formula = req.body.formula;
    // Check if there is anything else besides 0-9 - * + /
    if(formula.match(/[^0-9\-\/\*\+]/)) {
        res.send('Invalid input');
        return;
    }

    var result;
    eval('result = ' + formula);
    res.send('The result is: ' + result);
});

app.listen(3000);