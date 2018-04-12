/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import { SUCCESS, FAILURE, WAITING } from './saveStatus';

function AlertBox({ status }) {
  if (status === FAILURE) {
    return <div className="mv2">Save failed</div>;
  } else if (status === SUCCESS) {
    return <div className="mv2">Save successful</div>;
  } else if (status === WAITING) {
    return <div className="mv2">Saving…</div>;
  } else {
    return null;
  }
}

export default AlertBox;
