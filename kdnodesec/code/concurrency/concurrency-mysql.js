/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

    //CREATE TABLE `wallets` (
    //`name` varchar(128) NOT NULL,
    //`amount` double(10,2) NOT NULL,
    //    PRIMARY KEY (`name`),
    //KEY `name` (`name`)
    //) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    //
    //INSERT INTO `wallets` (`name`, `amount`) VALUES
    //('karl', 1000.00),
    //('mikk', 1000.00);

var mysql = require('mysql');
var args = require('minimist')(process.argv);

if(!args.u || !args.d || !args.p) {
    console.log('This example requires the ' +
    '-u (user), ' +
    '-d (mysql db) and ' +
    '-p (password) command line variables');

    process.exit();
}

var connection = mysql.createConnection({
    host     : 'localhost',
    user     : args.u,
    database : args.d,
    password : args.p
});
connection.connect();

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
app.use(bodyParser.urlencoded());

app.get('/:name', function(req, res, next){
    // Query the account based on url parameters
    connection.query('SELECT * FROM wallets WHERE name= ?', [req.params.name],
        function(err, rows) {
            if (err) {
                next(err);
                return;
            }
            res.send(
                '<p> You have: ' + rows[0].amount + '.<br/>' +
                'How much do you want to withdraw?</p>' +
                '<form method="POST">' +
                    '<input type="number" name="amount" />' +
                    '<input type="submit" value="submit" />' +
                '</form>');
        });
});

app.post('/:name', function(req, res, next){
    var amount = Math.abs(req.body.amount);
    var query = 'UPDATE wallets SET amount = amount - ? ' +
        'WHERE amount >= ? AND name = ?';

    connection.query(query, [amount, amount, req.params.name],
        function(err, result) {
            if (err) { // Something went wrong with the query
                next(err);
                return;
            }

            if(result.changedRows !== 1) {
                // Not enough money and change didn't go through
                res.send(400, 'Insufficient funds');
                return;
            }
            processFn(function (processErr) {
                if(!processErr) { // All done
                    res.redirect('/' + req.params.name);
                    return;
                }
                // Something went wrong so reimburse
                var reimburse = 'UPDATE wallets ' +
                    'SET amount = amount + ? WHERE name = ?';
                connection.query(reimburse, [amount, req.params.name],
                    function (rErr, result) {
                        if(rErr || result.changedRows !== 1) {
                            //FIXME: Now we have a problem,
                            // this should trigger a fallback
                            // or a red flag so that
                            // this change would not be lost
                        }
                        res.redirect('/' + req.params.name);
                    });
            });
        });
});

app.listen(3000);