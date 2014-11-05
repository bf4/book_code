/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
'use strict';
const
  countdown = function* (count) {
    while (count > 0) {
      yield count;
      count -= 1;
    }
  },
  
  counter = countdown(5),
  
  callback = function(){
    let item = counter.next();
    if (!item.done) {
      console.log(item.value);
      setTimeout(callback, 1000);
    }
  };
callback();

