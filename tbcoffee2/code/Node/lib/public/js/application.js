/***
 * Excerpted from "CoffeeScript: Accelerated JavaScript Development, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbcoffee2 for more book information.
***/
(function() {
  var fetchInitialData, renderBoard;

  fetchInitialData = $.when(new window.CardCollection().fetch({
    parse: false
  }), new window.ColumnCollection().fetch({
    parse: false
  }), new window.BoardCollection().fetch({
    parse: false
  }));

  fetchInitialData.then((function(_this) {
    return function(_arg, _arg1, _arg2) {
      var boardData, cardData, columnData, options;
      cardData = _arg[0];
      columnData = _arg1[0];
      boardData = _arg2[0];
      options = {
        parse: true
      };
      window.allCards = new window.CardCollection(cardData, options);
      window.allColumns = new window.ColumnCollection(columnData, options);
      window.allBoards = new window.BoardCollection(boardData, options);
      renderBoard();
    };
  })(this));

  renderBoard = (function(_this) {
    return function() {
      var $board, board, boardView;
      board = window.allBoards.last();
      $board = $("<div class='board' data-board-id='" + (board.get('id')) + "'></div>");
      $('body').append($board);
      return boardView = new window.BoardView({
        model: board,
        el: $board
      }).render();
    };
  })(this);

}).call(this);

//# sourceMappingURL=application.js.map
