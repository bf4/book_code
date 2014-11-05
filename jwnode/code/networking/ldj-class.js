/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
"use strict";
const EventEmitter = require('events').EventEmitter;
class LDJClient extends EventEmitter {
  constructor(stream) {
    
    super();
    
    let
      self = this,
      buffer = "";
    
    stream.on('data', function(data) {
      buffer += data;
      let boundary = buffer.indexOf("\n");
      while (boundary != -1) {
        let input = buffer.substr(0, boundary);
        buffer = buffer.substr(boundary + 1);
        self.emit('message', JSON.parse(input));
        boundary = buffer.indexOf("\n");
      }
    });
    
  }
}

exports.LDJClient = LDJClient;
exports.connect = function(stream){
  return new LDJClient(stream);
};

