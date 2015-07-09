/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

// Node.js built in crypto library
var crypto = require('crypto');

// bcrypt and scrypt libraries
var bcrypt = require('bcrypt');
var scrypt = require('scrypt');

var text = 'hello';

// A generic hash function to use the
// crypto library with different hashes
function hash(alg, text) {
    // Start timer
    console.time(alg);

    // Create hex result of hash
    var hash = crypto.createHash(alg);
    hash.update(text);
    var result = hash.digest('hex');

    // Log result and time taken
    console.log(alg + ': ' + result);
    console.timeEnd(alg);
}

// Calculate common hashes
hash('md5', text);
hash('sha1', text);
hash('sha256', text);
hash('sha512', text);

// Calculate hash using bycrypt
console.time('bcrypt');
bcrypt.hash(text, 12, function (err, hash) {
    if(err) {
        console.error(err);
        process.exit();
    }
    console.log('bcrypt: ' + hash);
    console.timeEnd('bcrypt');
});

// Set up scrypt parameters
var scryptParams = scrypt.params(1);
scrypt.hash.config.keyEncoding = 'utf8';
scrypt.hash.config.outputEncoding = 'hex';

// Calculate hash using scrypt
console.time('scrypt');
scrypt.hash(text, scryptParams, function (err, hash) {
    if(err) {
        console.error(err);
        process.exit();
    }
    console.log('scrypt: ' + hash);
    console.timeEnd('scrypt');
});