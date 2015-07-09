/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
var http = require('http'); // Require internal http module

// Create a server with a callback that is run on every request
http.createServer(function (req, res) {

    // Respond with Hello World
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello World\n');

})
// Start listening for localhost connections on port 1337
.listen(1337, '127.0.0.1');

// Log that we have created the server.
console.log('Server running at http://127.0.0.1:1337/');