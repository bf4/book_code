/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
// Helpers for writing server-side _list functions in CouchDB
exports.withRows = function(fun) {
 var f = function() {
    var row = getRow();
    return row && fun(row);
  };
  f.iterator = true;
  return f;
}

exports.send = function(chunk) {
  send(chunk + "\n")
}