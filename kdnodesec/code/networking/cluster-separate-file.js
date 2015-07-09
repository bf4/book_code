/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var cluster = require('cluster');
// Ask the number of CPU-s for optimal forking (one fork per CPU)
var numCPUs = require('os').cpus().length;

cluster.setupMaster({
    exec : 'index.js' // Points to the index file you want to fork
});

// Fork workers.
for (var i = 0; i < numCPUs; i++) {
    cluster.fork();
}

cluster.on('disconnect', function(worker) {
    console.error('disconnect!'); // This can probably use some work.
    cluster.fork();
});