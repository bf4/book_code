/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
// Source: https://raw.github.com/mhevery/jasmine-node/master/lib/jasmine-node/async-callback.js
(function() {
  var withoutAsync = {};

  ["it", "beforeEach", "afterEach"].forEach(function(jasmineFunction) {
    withoutAsync[jasmineFunction] = jasmine.Env.prototype[jasmineFunction];
    return jasmine.Env.prototype[jasmineFunction] = function() {
      var args = Array.prototype.slice.call(arguments, 0);
      var timeout = null;
      if (isLastArgumentATimeout(args)) {
         timeout = args.pop();
      }
      if (isLastArgumentAnAsyncSpecFunction(args))
      {
        var specFunction = args.pop();
        args.push(function() {
          return asyncSpec(specFunction, this, timeout);
        });
      }
      return withoutAsync[jasmineFunction].apply(this, args);
    };
  });

  function isLastArgumentATimeout(args)
  {
    return args.length > 0 && (typeof args[args.length-1]) === "number";
  }

  function isLastArgumentAnAsyncSpecFunction(args)
  {
    return args.length > 0 && (typeof args[args.length-1]) === "function" && args[args.length-1].length > 0;
  }

  function asyncSpec(specFunction, spec, timeout) {
    if (timeout == null) timeout = jasmine.DEFAULT_TIMEOUT_INTERVAL || 1000;
    var done = false;
    spec.runs(function() {
      try {
        return specFunction(function(error) {
          done = true;
          if (error != null) return spec.fail(error);
        });
      } catch (e) {
        done = true;
        throw e;
      }
    });
    return spec.waitsFor(function() {
      if (done === true) {
        return true;
      }
    }, "spec to complete", timeout);
  };

}).call(this);
