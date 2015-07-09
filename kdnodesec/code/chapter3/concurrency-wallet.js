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
    if(db[key] === undefined) {
        db[key] = 1000; // Lets give everyone a thousand at first
    }
    setImmediate(cb, null, db[key]);
}

function save(key, value, cb) {
    db[key] = value;
    setImmediate(cb);
}

var db = {
    find: find,
    save: save
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

app.post('/:name', function (req, res) {
    db.find(req.params.name, function (err, amount) {
        if(err) {
            next(err);
            return;
        }
        // We will ignore the fact that the input should
        // be validated to be a number
        var leftAmount =  amount - Math.abs(req.body.amount);
        // Check if we have enough funds
        if(leftAmount < 0) {
            res.send(400, 'Insufficient funds');
            return;
        }

        processFn(function (processErr) {
            if(processErr) {
                // Something went wrong so we don't charge
                next(processErr);
                return;
            }
            // Save the new amount to db
            db.save(req.params.name, leftAmount, function (sErr) {
                if(sErr) {
                    next(sErr);
                    return;
                }
                res.redirect('/' + req.params.name);
            });
        });
    });
});

app.listen(3000);