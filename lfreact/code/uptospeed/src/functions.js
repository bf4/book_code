/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
const test1 = {
  sample: function() {
    this.color = 'green';
  }
};
const test2 = {
  sample: function() {
    this.color = 'green';
  }
};

const result1 = test1.sample();
const result2 = new test2.sample();
test1.color === 'green'; // evaluates to true
result1 === undefined; // evaluates to true

test2.colour === undefined; // evaluates to true
typeof result2; // returns "object"
result2.color === 'greeen'; // returns true

function add(x, y) {
  return x + y;
}
let n = 1;

function addS(x, y) {
  const result = x + n * y;
  n++;
  return result;
}

function multiply(x, y) {
  return x * y * n++;
}


export default {
  test1: test1,
  test2: test2,
  result1: result1,
  result2: result2
};
