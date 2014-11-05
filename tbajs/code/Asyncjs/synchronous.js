/***
 * Excerpted from "Async JavaScript",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbajs for more book information.
***/
var fs = require('fs');
process.chdir('recipes');  // change the working directory

var concatenation = '';

fs.readdirSync('.')
  .filter(function(filename) {
    // ignore directories
    return fs.statSync(filename).isFile();
  })
    .forEach(function(filename) {
      // add contents to our output
      concatenation += fs.readFileSync(filename, 'utf8');
    });

console.log(concatenation);
