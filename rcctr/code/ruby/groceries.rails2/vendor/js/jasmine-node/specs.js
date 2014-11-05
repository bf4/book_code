/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
require.paths.push("./lib");
var jasmine = require('jasmine');
var sys = require('sys');

for(var key in jasmine) {
  global[key] = jasmine[key];
}

var isVerbose = false;
var showColors = true;
process.argv.forEach(function(arg){
  switch(arg) {
  case '--color': showColors = true; break;
  case '--noColor': showColors = false; break;
  case '--verbose': isVerbose = true; break;
  }
});

jasmine.executeSpecsInFolder(__dirname + '/../../../spec/javascripts',
  function(runner, log){
    process.exit(runner.results().failedCount);
  }, isVerbose, showColors);
