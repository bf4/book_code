/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/

import React from 'react';

function ProgressBar({ completion }) {
  const percentage = completion * 100;
  return (
    <div className="mv2 flex flex-column">
      <label htmlFor="progress" className="mv2">
        Progress
      </label>
      <progress value={completion} id="progress" className="bn">
        {percentage}%
      </progress>
    </div>
  );
}
export default ProgressBar;
