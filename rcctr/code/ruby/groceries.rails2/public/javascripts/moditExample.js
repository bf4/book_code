/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
if (app === undefined) { app = {}; }
if (app.example === undefined) { app.example = {}; }

app.example.mynamespace = (function() {
  function internalFunction() {
    return "internal";
  }

  function exportedFunction() {
    return "exported";
  }
  
  var exports = {
    exportedFunction: exportedFunction
  };
  return exports;
})();

modit('app.example.mynamespace', function() {
  function internalFunction() {
    return "internal";
  }

  function exportedFunction() {
    return "exported";
  }
  this.exports(exportedFunction);
});
