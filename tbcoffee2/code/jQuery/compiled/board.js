/***
 * Excerpted from "CoffeeScript: Accelerated JavaScript Development, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbcoffee2 for more book information.
***/
(function() {
  var boardData,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Board = (function(_super) {
    __extends(Board, _super);

    function Board() {
      return Board.__super__.constructor.apply(this, arguments);
    }

    Board.prototype.defaults = {
      name: 'New Board'
    };

    Board.prototype.parse = function(data) {
      var attrs, columnId, _ref;
      attrs = _.omit(data, 'columnIds');
      attrs.columns = (_ref = this.get('columns')) != null ? _ref : new window.ColumnCollection;
      attrs.columns.reset((function() {
        var _i, _len, _ref1, _results;
        _ref1 = data.columnIds || [];
        _results = [];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          columnId = _ref1[_i];
          _results.push(window.allColumns.get(columnId));
        }
        return _results;
      })());
      return attrs;
    };

    Board.prototype.toJSON = function() {
      var data;
      data = _.omit(this.attributes, 'columns');
      data.columnIds = this.get('columns').pluck('id');
      return data;
    };

    return Board;

  })(Backbone.Model);

  window.BoardCollection = (function(_super) {
    __extends(BoardCollection, _super);

    function BoardCollection() {
      return BoardCollection.__super__.constructor.apply(this, arguments);
    }

    BoardCollection.prototype.model = Board;

    return BoardCollection;

  })(Backbone.Collection);

  boardData = JSON.parse(localStorage.boards);

  window.allBoards = new BoardCollection(boardData, {
    parse: true
  });

  window.BoardView = (function(_super) {
    __extends(BoardView, _super);

    function BoardView() {
      return BoardView.__super__.constructor.apply(this, arguments);
    }

    BoardView.prototype.initialize = function(options) {
      this.listenTo(this.model.get('columns'), 'add remove', (function(_this) {
        return function() {
          _this.model.save();
          return _this.render();
        };
      })(this));
      return BoardView.__super__.initialize.apply(this, arguments);
    };

    BoardView.prototype.render = function() {
      var html;
      html = JST['templates/board']({
        name: this.model.get('name'),
        columns: this.model.get('columns').toJSON()
      });
      this.$el.html(html);
      this.model.get('columns').forEach((function(_this) {
        return function(column) {
          var columnView;
          columnView = new window.ColumnView({
            model: column
          });
          columnView.setElement(_this.$("[data-column-id=" + (column.get('id')) + "]"));
          columnView.render();
          return columnView;
        };
      })(this));
      return this;
    };

    BoardView.prototype.events = {
      'change [name=board-name]': 'nameChangeHandler',
      'click [name=add-column]': 'addColumnClickHandler'
    };

    BoardView.prototype.nameChangeHandler = function(e) {
      this.model.save('name', $(e.currentTarget).val());
    };

    BoardView.prototype.addColumnClickHandler = function(e) {
      var newColumn;
      newColumn = new window.Column({}, {
        parse: true
      });
      newColumn.save();
      this.model.get('columns').add(newColumn);
    };

    return BoardView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=board.js.map
