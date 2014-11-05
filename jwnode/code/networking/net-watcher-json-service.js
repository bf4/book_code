/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
'use strict';
const
  
  fs = require('fs'),
  net = require('net'),
  
  filename = process.argv[2],
  
  server = net.createServer(function(connection) {
    
    // reporting
    console.log('Subscriber connected.');
    connection.write(JSON.stringify({
      type: 'watching',
      file: filename
    }) + '\n');
    
    // watcher setup
    let watcher = fs.watch(filename, function() {
      connection.write(JSON.stringify({
        type: 'changed',
        file: filename,
        timestamp: Date.now()
      }) + '\n');
    });
    
    // cleanup
    connection.on('close', function() {
      console.log('Subscriber disconnected.');
      watcher.close();
    });
  });

if (!filename) {
  throw Error('No target filename was specified.');
}

server.listen(5432, function() {
  console.log('Listening for subscribers...');
});

