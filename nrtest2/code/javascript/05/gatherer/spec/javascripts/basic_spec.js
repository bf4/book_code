/***
 * Excerpted from "Rails 4 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
***/
describe('This is how jasmine works', function() {
  it("can do basic math", function() {
    expect(1 + 1).toEqual(2);
  });

  it("also knows when math is wrong", function() {
    expect(1 + 1).not.toEqual(3);
  });
});
