/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
// Not sure why this doesn't work, but it doesn't
(function() {
  var root = this;
  root.using = function() {
    var namespace = _.first(arguments);
    var scope = _.last(arguments);
    return function() {
      scope();
    };
  };
})();

modit('modit.mock', function() {
  function isTuple(list) { return list.length == 2; }
  function invokeIf(value, func) { if (value) { func(value); } }
  function throwNameError(badTuple) {  
        throw "Invalid argument name '" + badTuple[0] + "' would replace existing function on mock";
  }

  // Probably need to rename this to spy
  function func () {
    var argumentNames = arguments;
    var mockFunction = function() {
      function alreadyDefined(tuple) {
        return mockFunction.callCount === 1 && mockFunction[tuple[0]];
      }
      mockFunction.callCount++;
      var tuples = _.select(_.zip(argumentNames, arguments), isTuple);
      invokeIf(_.detect(tuples, alreadyDefined), throwNameError);
      _.each(tuples, function(tuple) { mockFunction[tuple[0]] = tuple[1]; });
    };
    mockFunction.callCount = 0;
    return mockFunction;
  }

  function funcify (returnValue) {
    return function() {
      return returnValue;
    };
  }

  function dub (definition) {
    function toFunctions(memo, key) { 
      memo[key] = func.apply(null,definition[key]);
      return memo;
    }
    return _.reduce(_.keys(definition), toFunctions, {}); 
  }
  this.exports(func, funcify, dub);
});
