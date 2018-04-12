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
import WordCounter from './WordCounter';

export function init(element, target = 10) {
  ReactDOM.render(<WordCounter targetWordCount={target} />, element);
}
export function destroy(element) {
  ReactDOM.unmountComponentAtNode(element);
}
