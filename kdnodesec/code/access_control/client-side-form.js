/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

// Our imaginary DB
var db = {
    users: {
        _index: 1,
        1: { username: 'admin', name: 'Admin', company: 'This', isAdmin: 1}
    }
};

var cookieParser = require('cookie-parser');
var easySession = require('easy-session');
var session = require('express-session');
var bodyParser = require('body-parser');
var express = require('express');
var app = express();

app.use(cookieParser());
app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true
}));
app.use(bodyParser.urlencoded({extended: false}));
app.use(easySession.main(session));

// Show a welcome message
app.get('/', function (req, res, next) {
    res.send('<h1>Welcome</h1><a href="/register">Register</a>');
});

// Show registration form
app.get('/register', function (req, res, next) {
    var form = '<form method="POST">' +
        '<input type="text" name="username" placeholder="username" />' +
        '<input type="text" name="name" placeholder="name" />' +
        '<input type="text" name="company" placeholder="company" />';
    // If logged in then show admin checkbox
    if(req.session.isLoggedIn()) {
        form += '<label for="isAdmin">Is Admin? ' +
        '<input id="isAdmin" type="checkbox" name="isAdmin" value="1" /></label>';
    }
    form += '<input type="submit" value="Submit" />' +
    '</form>';

    res.send(form);
});
// Post request handler
app.post('/register', function (req, res, next){
    var newUser = {
        username: req.body.username,
        name: req.body.name,
        company: req.body.company,
        isAdmin: req.body.isAdmin || 0 // if no isAdmin is sent then set to 0
    };
    db.users[++db.users._index] = newUser;

    console.log(db.users); // show us the users
    res.redirect('/');
});
app.listen(3000);