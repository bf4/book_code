/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
(function(app) {
  app.directive("urlFormat", function() {
    var urlPattern = new RegExp(
      "(http|https):\\/\\/(\\w+:{0,1}\\w*@)?(\\S+)(:[0-9]+)?" +
      "(\\/|\\/([\\w#!:.?+=&%@!\\-\\/]))?");
              
    var getParser = function(controller) { /* (1) */
      return function(value) {
        var valid = urlPattern.test(value);
        controller.$setValidity("urlFormat", valid);
        return valid ? value : undefined;
      };
    };

    return {
      require: "ngModel", /* (2) */
      
      link: function(scope, elem, attrs, controller) { /* (3) */
        controller.$parsers.push(getParser(controller));
      }
    };
  });
})(angular.module("App_validation", ["ngResource", "App_base"]));
