/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/

'use strict';

var http = require('http');
var domain = require('domain');

http.createServer(function(req, res) {
    var d = domain.create();
    d.on('error', function(err) {
        console.error(err); // log the error
        // Can also do some logging about the request here

        // Respond to the request with an error message
        res.writeHead(500, {'Content-Type': 'text/plain'});
        res.end('Something bad happened!');
    });

    // Because req and res were created before this domain existed,
    // we need to explicitly add them.
    // See the explanation of implicit vs explicit binding below.
    d.add(req);
    d.add(res);

    // Now run the handler function in the domain.
    d.run(function() {
        handleRequest(req, res);
    });
});

function handleRequest(req, res) {
    switch(req.url) {
        case '/error':
            throw new Error('whoops');
            break;
        default:
            res.end('ok');
            break;
    }
}