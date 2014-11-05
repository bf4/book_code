/***
 * Excerpted from "Rails 4 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
***/
customMatchers = {
  toMatchDomIds: function(util, customEqualityTesters) {
    return {
      compare: function(actual, expected) {
        var result = {};
        actualIds = $.map($("tr"), function(item) { return $(item).attr("id") });
        result.pass = util.equals(actualIds, expected, customEqualityTesters);
        if (result.pass) {
          result.message = "Expected " + actual + " not to have DOM Ids" +
              expected + ". Instead it had " + actualIds
        } else {
          result.message = "Expected " + actual + " to have DOM Ids " +
              expected + ". Instead it had " + actualIds
        }
        return result;
      }
    }
  }
}
