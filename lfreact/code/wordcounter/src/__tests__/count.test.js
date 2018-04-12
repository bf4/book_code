/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import countWords from '../countWords';
describe('the counting function', () => {
  it('counts the correct number of words', () => {
    expect(countWords('One two three')).toBe(3);
  });
  it('counts an empty string', () => {
    expect(countWords('')).toBe(0);
  });
});
