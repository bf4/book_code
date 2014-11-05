/***
 * Excerpted from "CoffeeScript: Accelerated JavaScript Development, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbcoffee2 for more book information.
***/
(function() {
  Backbone.sync = function(method, model, options) {
    var collection, localStorageKey, xhr;
    if (model instanceof window.Card) {
      collection = window.allCards;
      localStorageKey = 'cards';
    } else if (model instanceof window.Column) {
      collection = window.allColumns;
      localStorageKey = 'columns';
    } else if (model instanceof window.Board) {
      collection = window.allBoards;
      localStorageKey = 'boards';
    }
    switch (method) {
      case 'get':
        model.reset(collection.get(model.id), {
          silent: true
        });
        break;
      case 'create':
        model.set('id', collection.length + 1);
        collection.add(model);
        localStorage[localStorageKey] = JSON.stringify(collection.toJSON());
        break;
      case 'update':
        localStorage[localStorageKey] = JSON.stringify(collection.toJSON());
    }
    xhr = options.xhr = jQuery.Deferred().resolve(model.toJSON()).promise();
    options.success(model.toJSON());
    return xhr;
  };

  $(function() {
    var $board, board, boardView;
    board = window.allBoards.last();
    $board = $("<div class='board' data-board-id='" + (board.get('id')) + "'></div>");
    $('body').append($board);
    boardView = new window.BoardView({
      model: board,
      el: $board
    }).render();
  });

}).call(this);

//# sourceMappingURL=application.js.map
