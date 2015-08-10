/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
***/
/**
 * @constructor
 */
jasmine.MultiReporter = function() {
  this.subReporters_ = [];
};
jasmine.util.inherit(jasmine.MultiReporter, jasmine.Reporter);

jasmine.MultiReporter.prototype.addReporter = function(reporter) {
  this.subReporters_.push(reporter);
};

(function() {
  var functionNames = [
    "reportRunnerStarting",
    "reportRunnerResults",
    "reportSuiteResults",
    "reportSpecStarting",
    "reportSpecResults",
    "log"
  ];
  for (var i = 0; i < functionNames.length; i++) {
    var functionName = functionNames[i];
    jasmine.MultiReporter.prototype[functionName] = (function(functionName) {
      return function() {
        for (var j = 0; j < this.subReporters_.length; j++) {
          var subReporter = this.subReporters_[j];
          if (subReporter[functionName]) {
            subReporter[functionName].apply(subReporter, arguments);
          }
        }
      };
    })(functionName);
  }
})();
