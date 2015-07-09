/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';
// SETUP a in-memory DB with username:password lookup

var db = {
    1:{
        username: 'johann',
        password: 'pw',
        name: 'Johann',
        company: 'Mixo',
        age: 32
    },
    2:{
        username: 'andris',
        password: 'pw2',
        name: 'Andris',
        company: 'Apple',
        age: 22
    },
    3:{
        username: 'brian',
        password: 'pw3',
        name: 'Brian',
        company: 'Apple',
        age: 26
    },
    4:{
        username: 'jake',
        password: 'pw4',
        name: 'Jake',
        company: 'Shell',
        age: 53
    }
};

function matchUsernamePassword(username, password) {
    if(!username || !password) {
        return {success:false, error: 'Missing username or password'};
    }
    var userId;
    Object.keys(db).some(function (id) {
        if(db[id].username === username) {
            userId = id;
            return true;
        }
    });
    if(!userId || db[userId].password !== password) {
        return {success: false, error: 'Wrong username or password'};
    }
    return {success: true, userId: userId};
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

app.get('/', function(req, res){
    // if the user is logged in then redirect to their home
    if(!req.session.isGuest()) {
        res.redirect('/user/' + req.session.userId);
        return;
    }
    var form = '<form method="POST" action="/login">' +
        '<input type="text" name="username" placeholder="username" />' +
        '<input type="password" name="password" placeholder="password" />' +
        '<input type="submit" value="Login" />' +
        '</form>';
    if(req.session.error) { // If we had an error then show it
        form += '<div>' + req.session.error + '</div>';
    }
    req.session.error = null; // Delete error.
    res.send(form);
});

app.post('/login', function (req, res) {
    var valid = matchUsernamePassword(req.body.username, req.body.password);
    if(valid.success) { // Validation success. Create authorized session.
        req.session.login(function () {
            req.session.userId = valid.userId;
            res.redirect('/settings/' + valid.userId);
        });
    } else {
        req.session.error = valid.error;
        res.redirect('/');
    }
});

app.get('/logout', function (req, res) {
    req.session.logout(function () {
        res.redirect('/');
    });
});

// Middleware to validate that users are authenticated
app.all('*', function (req, res, next) {
    if(req.session.isGuest()) {
        res.send(401);
        return;
    }
    next();
});

app.get('/settings/:id', function (req, res) {
    res.json(db[req.params.id]);
});

app.listen(3000);
