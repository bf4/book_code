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
  fs = require('fs'),
  spawn = require('child_process').spawn,
  
  // begin watching the specified file
  startWatching = function(filename) {
    fs.watch(filename, function() {
      let ls = spawn('ls', ['-lh', filename]);
      ls.stdout.pipe(process.stdout);
    });
    console.log("Now watching " + filename + " for changes...");
  };

// buffered input to scan for file names
let input = '';

// scan standard input for files to watch, one per line
process.stdin.on('data', function(chunk){
  input += chunk;
  while (input.indexOf("\n") >= 0) {
    let filename = input.substr(0, input.indexOf("\n"));
    startWatching(filename);
    input = input.substr(filename.length + 1);
  }
});
process.stdin.resume();

