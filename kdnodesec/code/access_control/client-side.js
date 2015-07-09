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
var easySession = require('easy-session');

// Our imaginary DB
var db = {
    users: {
        1: { username: 'johann', name: 'Johann', company: 'Mixo', age: 32},
        2: { username: 'andris', name: 'Andris', company: 'Apple', age: 22},
        3: { username: 'brian', name: 'Brian', company: 'Apple', age: 26},
        4: { username: 'jake', name: 'Jake', company: 'Shell', age: 53}
    }
};

var app = express();

var cookieParser = require('cookie-parser');
var session = require('express-session');
app.use(cookieParser());
app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true
}));
app.use(easySession.main(session));

// Function to build menu
function getNav(req) {
    var html = '<nav>' +
        '<a href="/page/1">Page 1</a> ' +
        '<a href="/page/2">Page 2</a> ' +
        '<a href="/page/3">Page 3</a> ';

    if(req.session.isLoggedIn()) {
        html += '<a href="/users">Users</a>';
    }
    html += '</nav>';
    return html;
}

// Show a welcome message
app.get('/', function (req, res, next) {
    var html = getNav(req) + '<br/><div>Welcome home</div>';
    res.send(html);
});

// Regular pages, show what page we are on
app.get('/page/:nr', function (req, res, next){
    var html = getNav(req) + '<div>Page ' + req.params.nr +'</div>';
    res.send(html);
});

// Our admin function to show users
app.get('/users', function (req, res, next) {
    var html = getNav(req) + '<pre>' + JSON.stringify(db.users, '', 2) +'</pre>';
    res.send(html);
});

app.listen(3000);