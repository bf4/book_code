/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var fs = require('fs');

var dictionary = {};

// Since we are doing it only once on startup then use sync function
var file = fs.readFileSync('./data/dictionary.txt', 'utf8');

file.split('\n').forEach(function (password) {
    dictionary[password] = true;
});

file = null; // free memory

// This function will return an error message if the password is not good
// or false if it is proper
module.exports.isImproper = function check(username, password) {

    // About 3 percent of users derive the password from the username
    // This is not very secure and should be disallowed
    if(password.indexOf(username) !== -1) {
        return 'Password must not contain the username';
    }

    // Compare against dictionary
    if(dictionary[password]) {
        return 'Do not use a common password like: ' + password;
    }
    return false;
};
