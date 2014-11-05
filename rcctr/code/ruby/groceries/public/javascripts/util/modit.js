/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
(function() {
  var root = this;
  root.modit = function() {
    var util = modit.util;
    var name = _.first(arguments);
    var definition = _.last(arguments);
    var imports = _.flatten(_.map(_.flatten(_.select(arguments, _.isArray)), function(arg) {
      if (isFunctionDef(arg)) { return wrapper(arg); }
      return util.createNamespace(arg);
    }));

    function wrapper(functionDef) {
      var split = functionDef.split('#');
      var ns = util.createNamespace(split[0]);
      return _.map(split.slice(1), function(funcName) {
        return function() {
          if (_.isUndefined(ns[funcName])) { throw "function " + split[0] + "." + funcName + "() is not defined"; }
          return ns[funcName].apply(ns, arguments);
        };
      });
    }

    function isFunctionDef(arg) {
      return arg.indexOf('#') >= 0;
    }

    function ensureDefined(ref) {
      return util.some(ref, function() {
        throw new Error("Module " + name + " does not return its exports. (Did you forget to call 'return this.exports()'?)");
      });
    }

    function toModuleObject(module, func) {
      module = module || {};
      var functionName = util.nameOf(func);
      module[functionName] = func || module[functionName];
      return module;
    }

    function gatherExports(exports) {
      return _.reduce(
        _.select(exports, _.isFunction), 
        toModuleObject
      );
    }

    function exports(method) {
      _.extend(util.createNamespace(name), gatherExports(arguments));
    }
    var context = util.createNamespace(name);
    context.exports = exports;
    definition.apply(context, imports);
    delete context.exports;
  };

  root.modit.util = (function() {
    function nameOf(func) {
      return func.toString().match(/\s*function\s*([a-zA-Z0-9_\$]*)\(/)[1];
    }

    function some(ref, func) {
      if (_.isUndefined(ref)) {
        return func();
      }
      return ref;
    }

    function createNamespace(name) {
      // If this reduce fails, make sure you're using the version of underscore
      // that comes with modit (and not an earlier one)
      return _.reduce(name.split('.'), function(parentNs, ns) {
        return (parentNs[ns] = parentNs[ns] || {});
      }, root);
    }

    return {
      nameOf: nameOf,
      createNamespace: createNamespace,
      some: some
    };
  })();
})();
