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
var http = require('http');
// Ask the number of CPU-s for optimal forking (one fork per CPU)
var numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
    // Fork workers.
    for (var i = 0; i < numCPUs; i++) {
        cluster.fork();
    }

    // Log when a worker exits
    cluster.on('exit', function(worker, code, signal) {
        console.log('worker ' + worker.process.pid + ' died');
    });

    // If a worker disconnects then recreate it
    cluster.on('disconnect', function(worker) {
        console.error('disconnect!');
        cluster.fork();
    });
} else {

    // Workers can share any TCP connection
    // In this case its a HTTP server
    var server = http.createServer(function(req, res) {
        res.writeHead(200);
        res.end("hello world\n");
    }).listen(3000);

    // Catch errors to log and send a disconnect
    process.on('uncaughtException', function (err) {

        // We use a try and catch because otherwise it would end up
        // in the same handler if for some reason anything goes wrong
        try {
            // make sure we close down within 30 seconds
            var killtimer = setTimeout(function() {
                process.exit(1);
            }, 30000);

            // But don't keep the process open just for that!
            killtimer.unref();

            // stop taking new requests.
            server.close();

            // Let the master know we're dead.  This will trigger a
            // 'disconnect' in the cluster master, and then it will fork
            // a new worker.
            cluster.worker.disconnect();

        } catch (er2) {
            // oh well, not much we can do at this point.
            console.error('Error shutting down gracefully!', er2.stack);
            process.exit(1);
        }

    });
}