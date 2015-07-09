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

function find(key, lock, cb) {
    if(_db[key] === undefined) {
        _db[key] = {
            amount: 1000, // Lets give everyone a thousand at first
            _locked: false // Default is unlocked
        };
    }
    var lockKey = undefined;
    if(lock) {
        if(_db[key]._locked) { // We are already locked so do not touch
            setImmediate(cb, new Error('Locked'));
            return;
        }
        // We will create a key, to allow changes only by that one process
        // certain that it is the same process that saves when locked
        _db[key]._locked = lockKey = Math.random().toString(36).substr(2);
    }
    setImmediate(cb, null, _db[key].amount, lockKey);
}

function save(key, value, lockKey, cb) {
    // If not correct key then return error
    if(_db[key]._locked !== lockKey) {
        setImmediate(cb, new Error('Locked'));
        return;
    }
    // Save
    _db[key] = {
        amount: value,
        _locked: false
    };
    setImmediate(cb);
}

// Function for unlocking a field
function unlock(key, lockKey, cb) {
    // If not correct key then return error
    if(_db[key]._locked !== lockKey) {
        setImmediate(cb, new Error('Wrong key'));
        return;
    }
    _db[key]._locked = false;
    setImmediate(cb);
}

var db = {
    find: find,
    save: save,
    unlock: unlock
};

//-----

// Our processing function
function processFn(cb) {
    // Add delay of 5 seconds here - imitating processing of the request
    setTimeout(cb, 5000);
}

var express = require('express');
var bodyParser = require('body-parser')
var app = express();
app.use(bodyParser.urlencoded({extended: false}));

app.get('/:name', function(req, res){
    // Find without locking
    db.find(req.params.name, false, function (err, amount) {
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
    // Find and lock
    db.find(req.params.name, true, function (err, amount, key) {
        if(err) {
            res.send(500);
            return;
        }
        // We will ignore the fact that the input should
        // be validated to be a number
        var leftAmount =  amount - Math.abs(req.body.amount);
        // Check if we have enough funds
        if(leftAmount < 0) {
            // Save old amount to unlock
            db.unlock(req.params.name, key, function (uErr) {
                if(uErr) {
                    //FIXME: This should be handled,
                    // probably with a forceUnlock function
                }
                res.send(400, 'Insufficient funds');
            });
            return;
        }
        // process
        processFn(function (pErr) {
            if(pErr) {
                db.unlock(req.params.name, key, function (uErr) {
                    if(uErr) {
                        //FIXME: This should be handled,
                        // probably with a forceUnlock function
                    }
                    next(pErr);
                });
                return;
            }
            // Save the new amount to db
            db.save(req.params.name, leftAmount, key, function (sErr) {
                if(sErr) {
                    //FIXME: This information should not be lost
                }
                res.redirect('/' + req.params.name);
            });
        });
    });
});

app.listen(3000);