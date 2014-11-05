/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
'use strict';
const
  rdfParser = require('../lib/rdf-parser.js'),
  expectedValue = require('./pg132.json');
exports.testRDFParser = function(test) {
  rdfParser(__dirname + '/pg132.rdf', function(err, book) {
    test.expect(2);
    test.ifError(err);
    test.deepEqual(book, expectedValue, "book should match expected");
    test.done();
  });
};
