/***
 * Excerpted from "Async JavaScript",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbajs for more book information.
***/
var x = new Backbone.Model({value: 0});
var y = new Backbone.Model({value: 0});
x.on('change:value', function(x, xVal) { y.set({value: xVal / 2}); });
y.on('change:value', function(y, yVal) { x.set({value: 2 * yVal}); });