/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import ReactDOM from 'react-dom';
import DatePicker from '../src/DatePicker';

describe('The date picker', () => {
  it('renders a calendar on input', () => {
    document.body.innerHTML = '<div id="app"></div>';
    ReactDOM.render(<DatePicker />, document.getElementById('app'));
    
    document.querySelector('input').dispatchEvent(new MouseEvent('click', {
      'view': window,
      'bubbles': true,
      'cancelable': true
    }));
    const ui = document.querySelector('table.pika-table');
    expect(ui).not.toBeNull();
  });

});
