/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
const
  fs = require('fs'),
  stream = fs.createReadStream(process.argv[2]);
stream.on('data', function(chunk) {
  process.stdout.write(chunk);
});
stream.on('error', function(err) {
  process.stderr.write("ERROR: " + err.message + "\n");
});

