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

// Our timer library
var timer = require('./timer');

var text = 'hello';

// A generic hash function to use the
// crypto library with different hashes
function hash(alg, text) {
    // Start timer
    timer.time(alg);

    // Create hex result of hash
    var hash = crypto.createHash(alg);
    hash.update(text);
    var result = hash.digest('hex');

    return {
        result: result,
        time: timer.timeEnd(alg)
    };
}

function bcryptHash(alg, text) {
    timer.time(alg);
    var hash = bcrypt.hashSync(text, 12);
    return {
        result: hash,
        time: timer.timeEnd(alg)
    };
}

// Set up scrypt parameters
var scryptParams = scrypt.params(1);
scrypt.hash.config.keyEncoding = 'utf8';
scrypt.hash.config.outputEncoding = 'hex';

function scryptHash(alg, text) {
    timer.time(alg);
    var hash = scrypt.hash(text, scryptParams);
    return {
        result: hash,
        time: timer.timeEnd(alg)
    };
}

function hashTime(fn, alg, text) {
    var result;
    var time = Infinity;
    var tmp;
    for(var i = 0; i < 10; i++) {
        tmp = fn(alg, text);
        result = tmp.result;
        if(tmp.time < time) {
            time = tmp.time;
        }
    }
    // Log result and time taken
    console.log(alg + ': ' + result);
    timer.formatPrint(time, alg);
}

// Calculate common hashes
hashTime(hash, 'md5', text);
hashTime(hash, 'sha1', text);
hashTime(hash, 'sha256', text);
hashTime(hash, 'sha512', text);
hashTime(bcryptHash, 'bcrypt', text);
hashTime(scryptHash, 'scrypt', text);