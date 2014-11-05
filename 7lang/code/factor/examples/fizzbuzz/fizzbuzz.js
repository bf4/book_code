/***
 * Excerpted from "Seven More Languages in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
***/
var fizzbuzz = function(t) {
  var results = [];

  for (var i = 1; i <= t; i++) {
    if (i % 15 == 0) {
      results.push("FizzBuzz");
    }
    else if (i % 3 == 0) {
      results.push("Fizz");
    }
    else if (i % 5 == 0) {
      results.push("Buzz");
    }
    else {
      results.push(String(i));
    }
  }

  return results;
};

console.log(fizzbuzz(100));
// prints ["1", "2", "Fizz", "4", "Buzz", ...]
