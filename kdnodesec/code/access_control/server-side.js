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

// Function for adding a user to the db
function addUser(data, admin) {
    var newUser = {
        username: data.username,
        name: data.name,
        company: data.company,
        isAdmin: admin
    };
    db.users[++db.users._index] = newUser;

    console.log(db.users); // show us the users
}

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

// Function to get the HTML form
function getForm(action) {
    return '<form method="POST" action="' + (action || '') + '">' +
        '<input type="text" name="username" placeholder="username" />' +
        '<input type="text" name="name" placeholder="name" />' +
        '<input type="text" name="company" placeholder="company" />' +
        '<input type="submit" value="Submit" />' +
        '</form>';
}
// Show registration form
app.get('/register', function (req, res, next) {
    res.send(getForm());
});

// Post request handler for regular users
app.post('/register', function (req, res, next){
    addUser(req.body, false); // Add a regular user
    res.redirect('/');
});

// Authentication middleware
app.get('*', easySession.isLoggedIn());

// Show the admin user adding form
app.get('/add-admin', function (req, res, next) {
    res.send(getForm('/add-admin'));
});

// Post request handler for adding admin users
app.post('/add-admin', function (req, res, next) {
    addUser(req.body, true); // Add admin user
    res.redirect('/');
});

app.listen(3000);