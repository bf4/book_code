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

  window.Card = (function(_super) {
    __extends(Card, _super);

    function Card() {
      return Card.__super__.constructor.apply(this, arguments);
    }

    return Card;

  })(Backbone.Model);

  window.CardCollection = (function(_super) {
    __extends(CardCollection, _super);

    function CardCollection() {
      return CardCollection.__super__.constructor.apply(this, arguments);
    }

    CardCollection.prototype.model = Card;

    CardCollection.prototype.url = '/cards';

    return CardCollection;

  })(Backbone.Collection);

  window.CardView = (function(_super) {
    __extends(CardView, _super);

    function CardView() {
      return CardView.__super__.constructor.apply(this, arguments);
    }

    CardView.prototype.render = function() {
      var html;
      html = JST['templates/card']({
        description: this.model.get('description'),
        dueDate: this.model.get('due-date')
      });
      this.$el.html(html);
      return this;
    };

    CardView.prototype.events = {
      'change [name=card-description]': 'descriptionChangeHandler',
      'change [name=due-date]': 'dueDateChangeHandler'
    };

    CardView.prototype.descriptionChangeHandler = function(e) {
      this.model.save('description', $(e.currentTarget).val());
    };

    CardView.prototype.dueDateChangeHandler = function(e) {
      this.model.save('due-date', $(e.currentTarget).val());
    };

    return CardView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=card.js.map
