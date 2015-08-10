/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
***/
describe("MatchersSpec - HTML Dependent", function () {
  var env, spec;

  beforeEach(function() {
    env = new jasmine.Env();
    env.updateInterval = 0;

    var suite = env.describe("suite", function() {
      spec = env.it("spec", function() {
      });
    });
    spyOn(spec, 'addMatcherResult');

    this.addMatchers({
      toPass: function() {
        return lastResult().passed();
      },
      toFail: function() {
        return !lastResult().passed();
      }
    });
  });

  function match(value) {
    return spec.expect(value);
  }

  function lastResult() {
    return spec.addMatcherResult.mostRecentCall.args[0];
  }

  it("toEqual with DOM nodes", function() {
    var nodeA = document.createElement('div');
    var nodeB = document.createElement('div');
    expect((match(nodeA).toEqual(nodeA))).toPass();
    expect((match(nodeA).toEqual(nodeB))).toFail();
  });
});