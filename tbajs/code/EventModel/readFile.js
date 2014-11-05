/***
 * Excerpted from "Async JavaScript",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbajs for more book information.
***/
var fs = require('fs');
fs.readFile('fhgwgdz.txt', function(err, data) {
  if (err) {
    return console.error(err);
  };
  console.log(data.toString('utf8'));
});