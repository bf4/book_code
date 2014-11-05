/***
 * Excerpted from "CoffeeScript: Accelerated JavaScript Development, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbcoffee2 for more book information.
***/
(function() {
  if (localStorage.boards == null) {
    localStorage.boards = JSON.stringify([
      {
        id: 1,
        name: 'New Board'
      }
    ]);
  }

  if (localStorage.columns == null) {
    localStorage.columns = JSON.stringify([]);
  }

  if (localStorage.cards == null) {
    localStorage.cards = JSON.stringify([]);
  }

}).call(this);

//# sourceMappingURL=data.js.map
