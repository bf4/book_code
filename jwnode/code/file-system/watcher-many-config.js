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
  
  // synchronously read the list of files to watch
  watchables = fs.readFileSync('watchables.txt').toString().split("\n");

watchables.forEach(function(filename){
  fs.watch(filename, function() {
    let ls = spawn('ls', ['-lh', filename]);
    ls.stdout.pipe(process.stdout);
  });
  console.log("Now watching " + filename + " for changes...");
});
