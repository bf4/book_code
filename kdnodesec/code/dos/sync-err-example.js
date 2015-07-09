/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

function someFn(input, callback) {
    if(input.hasError) {
        callback(new Error('Invalid input'));
        return;
    }
    // Do our stuff
}

function useSomeFn(req, res) {
    // Start information query as soon as possible
    someFn({hasError:true}, function (err, data) {
        if(err) {
            res.send(500);
            return;
        }
        res.json(data);
    });
    // Set some cookies in the meantime
    res.cookie('my', 'cookie');
}

function someFn(input, callback) {
    if(input.hasError) {
        setImmediate(callback, new Error('Invalid input'));
        return;
    }
    // Do our stuff
}