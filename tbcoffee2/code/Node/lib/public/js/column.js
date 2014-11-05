/***
 * Excerpted from "CoffeeScript: Accelerated JavaScript Development, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbcoffee2 for more book information.
***/
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Column = (function(_super) {
    __extends(Column, _super);

    function Column() {
      return Column.__super__.constructor.apply(this, arguments);
    }

    Column.prototype.defaults = {
      name: 'New Column'
    };

    Column.prototype.parse = function(data) {
      var attrs, cardId, _ref;
      attrs = _.omit(data, 'cardIds');
      attrs.cards = (_ref = this.get('cards')) != null ? _ref : new window.CardCollection;
      attrs.cards.reset((function() {
        var _i, _len, _ref1, _results;
        _ref1 = data.cardIds || [];
        _results = [];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          cardId = _ref1[_i];
          _results.push(window.allCards.get(cardId));
        }
        return _results;
      })());
      return attrs;
    };

    Column.prototype.toJSON = function() {
      var data;
      data = _.omit(this.attributes, 'cards');
      data.cardIds = this.get('cards').pluck('id');
      return data;
    };

    return Column;

  })(Backbone.Model);

  window.ColumnCollection = (function(_super) {
    __extends(ColumnCollection, _super);

    function ColumnCollection() {
      return ColumnCollection.__super__.constructor.apply(this, arguments);
    }

    ColumnCollection.prototype.model = Column;

    ColumnCollection.prototype.url = '/columns';

    return ColumnCollection;

  })(Backbone.Collection);

  window.ColumnView = (function(_super) {
    __extends(ColumnView, _super);

    function ColumnView() {
      return ColumnView.__super__.constructor.apply(this, arguments);
    }

    ColumnView.prototype.initialize = function(options) {
      this.cardViews = [];
      return ColumnView.__super__.initialize.apply(this, arguments);
    };

    ColumnView.prototype.render = function() {
      var html;
      html = JST['templates/column']({
        name: this.model.get('name'),
        cards: this.model.get('cards').toJSON()
      });
      this.$el.html(html);
      this.cardViews = this.model.get('cards').map((function(_this) {
        return function(card) {
          var cardView;
          cardView = new window.CardView({
            model: card
          });
          cardView.setElement(_this.$("[data-card-id=" + (card.get('id')) + "]"));
          cardView.render();
          return cardView;
        };
      })(this));
      return this;
    };

    ColumnView.prototype.events = {
      'change [name=column-name]': 'nameChangeHandler',
      'click [name=add-card]': 'addCardClickHandler'
    };

    ColumnView.prototype.nameChangeHandler = function(e) {
      this.model.save('name', $(e.currentTarget).val());
    };

    ColumnView.prototype.addCardClickHandler = function(e) {
      var newCard;
      newCard = new window.Card({}, {
        parse: true
      });
      allCards.add(newCard);
      newCard.save().then((function(_this) {
        return function() {
          _this.model.get('cards').add(newCard);
          _this.model.save();
          _this.render();
        };
      })(this));
    };

    return ColumnView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=column.js.map
