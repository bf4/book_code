/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var mongoose = require('mongoose');
var args = require('minimist')(process.argv);

if(!args.d) {
    console.log('This example requires the -d (mongoose db) command line variable');
    process.exit();
}

// Connect to mongoose db
mongoose.connect(args.d);

// Define wallet model
var walletSchema = new mongoose.Schema({
    name:  { type: String, required: true, index: { unique: true } },
    amount: { type: Number, required: true}
});
var Wallet = mongoose.model('Wallet', walletSchema);

Wallet.remove().exec(); // Delete all previous Wallets.

var bodyParser = require('body-parser');
var express = require('express');
var app = express();
app.use(bodyParser.urlencoded({extended: false}));

app.get('/:name', function(req, res, next){
    // Query the account based on url parameters
    Wallet.findOne({name: req.params.name}, function(err, wallet) {
        if (err) {
            next(err);
            return;
        }
        // Send information and withdrawal form
        res.send(
            '<p> You have: ' + wallet.amount + '.<br/>' +
            'How much do you want to withdraw?</p>' +
            '<form method="POST">' +
            '<input type="number" name="amount" />' +
            '<input type="submit" value="submit" />' +
            '</form>');
    });
});


// Our processing function
function processCall(cb) {
    // Add delay of 5 seconds here - imitating processing of the request
    setTimeout(cb, 5000);
}

app.post('/:name', function(req, res, next){
    var amount = Math.abs(req.body.amount);

    Wallet.findOne({name: req.params.name}, function (err, wallet) {
        if (err) { // Something went wrong with the query
            next(err);
            return;
        }
        if(!wallet) {
            res.send(404, 'Not found');
            return;
        }
        if(wallet.amount < amount) {
            res.send(400, 'Insufficient funds');
            return;
        }
        processCall(function () {
            wallet.amount -= amount;
            wallet.save(function (rErr, updatedW, rowsAffected) {
                if(rErr || rowsAffected !== 1) {
                    res.send(500, 'Withdrawal failed');
                    return;
                }
                res.redirect('/' + req.params.name);
            });
        });
    });
});

// Fill database
Wallet.create([
    { name: 'karl', amount: 1000},
    { name: 'mikk', amount: 1000 }
], function (err) {
    if(err) {
        console.error(err);
        process.exit(1);
    }
    console.log('Listening');
    app.listen(3000);
});
