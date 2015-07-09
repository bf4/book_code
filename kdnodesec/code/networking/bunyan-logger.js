/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';
var express = require('express');
var app = express();

var bunyan = require('bunyan');
var logger = bunyan.createLogger({name: 'My app', level: 'debug'});

app.use(function (req, res, next) {

    // Attach a logger to the request object
    req.log = logger.child({
        // Extend with a request id so we can easily group
        // all the log lines concerning this request later
        req_id: Math.random().toString(36).substr(2)
    });


    // Log request start
    req.log.debug({
        path: req.path,
        ip: req.ip,
        method: req.method
    }, 'Incoming request');

    var start = Date.now();
    function logRequest(){
        res.removeListener('finish', logRequest);
        res.removeListener('close', logRequest);

        // Log request end - duration and status code
        req.log.info({
            path: req.path,
            ip: req.ip,
            method: req.method,
            duration: Date.now() - start,
            status_code: this.statusCode
        }, 'Request ended');
    }

    res.on('finish', logRequest);
    res.on('close', logRequest);

    next();
});

var session = require('express-session');
app.use(session({secret: 'keyboard cat'}));

app.use(function (req, res, next) {
    if(req.session && req.session.user_id) {
        req.log = req.log.child({user_id: req.session.user_id});
    }
    next();
});

app.get('/', function (req, res) {
    res.send('hello, world!')
});

app.listen(3000);