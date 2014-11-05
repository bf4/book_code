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
      filename = process.argv[2];
    if (!filename) {
      throw Error("A file to watch must be specified!");
    }
    fs.watch(filename, function() {
      console.log("File " + filename + " just changed!");
    });
    console.log("Now watching " + filename + " for changes...");

