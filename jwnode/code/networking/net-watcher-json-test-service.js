/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
"use strict";
const
  
  net = require('net'),
  
  server = net.createServer(function(connection) {
    
    console.log('Subscriber connected');
    
    // send the first chunk immediately
    connection.write(
      '{"type":"changed","file":"targ'
    );
    
    // after a one second delay, send the other chunk
    let timer = setTimeout(function(){
      connection.write('et.txt","timestamp":1358175758495}' + "\n");
      connection.end();
    }, 1000);
    
    // clear timer when the connection ends
    connection.on('end', function(){
      clearTimeout(timer);
      console.log('Subscriber disconnected');
    });
    
  });

server.listen(5432, function() {
  console.log('Test server listening for subscribers...');
});

