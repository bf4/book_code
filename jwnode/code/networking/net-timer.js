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
  net = require('net'),
  
  server = net.createServer(function(connection) {
    
    console.log('Time subscriber connected');
    
    let timer = setInterval(function(){
      connection.write('Current date and time: ' + Date.now() + '\n');
    }, 1000);
    
    connection.on('end', function() {
      console.log('Time subscriber disconnected');
      clearTimeout(timer);
    });
    
  });

server.listen(5432, function() {
  console.log('Time server listening for subscribers...');
});
