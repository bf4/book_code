/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

// Define our database and functions
var _db = {};

function find(key, cb) {
    if(_db[key] === undefined) {
        _db[key] = 1000; // Lets give everyone a thousand at first
    }
    setImmediate(cb, null, _db[key]);
}

function save(key, value, cb) {
    _db[key] = value;
    setImmediate(cb);
}

function withDraw(key, amount, cb) {
    var left = _db[key] - amount;
    if(left < 0) {
        setImmediate(cb, new Error('Insufficient funds'));
        return;
    }
    _db[key] = left;
    setImmediate(cb, null, left);
}

function reimburse(key, amount, cb) {
    _db[key] += amount;
    setImmediate(cb, null);
}

var db = {
    find: find,
    save: save,
    withDraw: withDraw,
    reimburse: reimburse
};

//-----

// Our processing function
function processFn(cb) {
    // Add delay of 5 seconds here - imitating processing of the request
    setTimeout(function () {
        if(Math.random() < 0.3) {
            cb(new Error('Something went wrong'));
        } else {
            cb();
        }
    }, 5000);
}

var express = require('express');
var bodyParser = require('body-parser')
var app = express();
app.use(bodyParser.urlencoded({extended: false}));

app.get('/:name', function(req, res){
    db.find(req.params.name, function (err, amount) {
        if(err) {
            res.send(500);
            return;
        }
        // Send information and withdrawal form
        res.send(
            '<p> You have: ' + amount + '.<br/>' +
            'How much do you want to withdraw?</p>' +
            '<form method="POST">' +
                '<input type="number" name="amount" />' +
                '<input type="submit" value="submit" />' +
            '</form>');
    });
});

app.post('/:name', function (req, res, next) {
    // We will ignore the fact that the input should
    // be more thoroughly validated
    db.withDraw(req.params.name, Math.abs(req.body.amount), function (err, left) {
        if(err) {
            res.send(400, 'Insufficient funds');
            return;
        }
        // Add delay of 5 seconds here - imitating processing of the request
        processFn(function (pErr) {
            if(!pErr) {
                // All ok
                res.redirect('/' + req.params.name);
                return;
            }
            // Something went wrong so reimburse
            db.reimburse(req.params.name, Math.abs(req.body.amount),
                function (rErr) {
                    if(rErr) {
                        next(rErr);
                    }
                    res.redirect('/' + req.params.name);
                });
        });
    });
});

app.listen(3000);