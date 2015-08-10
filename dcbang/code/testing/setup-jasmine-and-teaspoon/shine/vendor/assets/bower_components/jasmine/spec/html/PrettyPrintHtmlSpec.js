/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
***/
describe("jasmine.pp (HTML Dependent)", function () {
  it("should stringify HTML nodes properly", function() {
    var sampleNode = document.createElement('div');
    sampleNode.innerHTML = 'foo<b>bar</b>';
    expect(jasmine.pp(sampleNode)).toEqual("HTMLNode");
    expect(jasmine.pp({foo: sampleNode})).toEqual("{ foo : HTMLNode }");
  });
});
