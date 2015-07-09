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
var bcrypt = require('bcrypt');
var Schema = mongoose.Schema;

var accountSchema = new Schema({
    email:  { type: String, required: true, index: { unique: true } },
    password: { type: String, required: true }
});

// Define pre-save hook
accountSchema.pre('save', function (next) {
    var user = this;

    // only hash the password if it has been modified (or is new)
    if (!user.isModified('password')) {
        return next();
    }

    bcrypt.hash(user.password, 12, function (err, hash) {
        if(err) {
            next(err);
            return;
        }
        user.password = hash;
        next();
    });
});

// Define a method to verify password validity
accountSchema.methods.isValidPassword = function (password, callback) {

    bcrypt.compare(password, this.password, function (err, isValid) {
        if(err) {
            callback(err);
            return;
        }
        callback(null, isValid);
    });
};

module.exports = accountSchema;