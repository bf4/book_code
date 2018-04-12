/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import ReactDOM from 'react-dom';
import React from 'react';
import ContactCollection from './ContactCollection';
import App from './App';

const collection = new ContactCollection();

ReactDOM.render(
  <App collection={collection} />,
  document.getElementById('app')
);
