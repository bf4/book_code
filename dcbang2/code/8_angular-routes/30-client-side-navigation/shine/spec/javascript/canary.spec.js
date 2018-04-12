/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
***/
import td from "testdouble/dist/testdouble";

describe("JavaScript testing", function() {
  it("works as expected", function() {
    var mockFunction = td.function();

    td.when(mockFunction(42)).thenReturn("Function Called!");

    expect(mockFunction(42)).toBe("Function Called!");
  });
});
