/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var url = require('url');

module.exports = function getCsrf(domainData) {
    if(typeof domainData !== 'object') {
        throw new TypeError('Expected an object');
    }

    // Function for validating the origin header
    function validate(origin) {
        var data = url.parse(origin);
        if(typeof data !== 'object') {
            return false;
        }
        // Match against the provided data
        return !Object.keys(domainData).some(function (key) {
            if(data[key] !== domainData[key]) {
                console.log(data[key], domainData[key]);
                return true;
            }
        });
    }

    // Define ignored methods
    var ignoredMethods = ['GET', 'HEAD', 'OPTIONS'];

    return function csrf(req, res, next) {

        // ignore speficied methods
        if (ignoredMethods.indexOf(req.method) !== -1) {
            next();
            return;
        }

        var origin = req.headers.origin || req.headers.referer;

        // Validate the header
        if(!origin || !validate(origin)) {
            var error = new Error('Unauthorized');
            error.code = 403;
            // Besides just saying that we had a mismatch
            // we should log some useful information about the request here
            // the user and referrer and origin headers of the request for example
            console.warn('Origin/Referer mismatch');
            next(error);
            return;
        }

        // Everything ok, so continue
        next();
    };
};