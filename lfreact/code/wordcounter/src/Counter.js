/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';

/*
function Counter({ count }) {
  return <p className="mb2">Word count: {count}</p>;
}
*/

function Counter({ count }) {
  return (
    <p className="mb2">
      <label htmlFor="count">Word count: </label>
      <output id="count">
        {count}
      </output>
    </p>
  );
}

export default Counter;
