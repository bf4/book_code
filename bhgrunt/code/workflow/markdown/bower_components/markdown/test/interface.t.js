/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
var markdown = require("../src/markdown"),
    test = require("tap").test;

function clone_array( input ) {
  // Helper method. Since the objects are plain round trip through JSON to get
  // a clone
  return JSON.parse( JSON.stringify( input ) );
}

test("arguments untouched", function(t) {
  var input = "A [link][id] by id.\n\n[id]: http://google.com",
      tree = markdown.parse( input ),
      clone = clone_array( tree ),
      output = markdown.toHTML( tree );

  t.equivalent( tree, clone, "tree isn't modified" );
  // We had a problem where we would accidentally remove the references
  // property from the root. We want to check the output is the same when
  // called twice.
  t.equivalent( markdown.toHTML( tree ), output, "output is consistent" );

  t.end();
});
