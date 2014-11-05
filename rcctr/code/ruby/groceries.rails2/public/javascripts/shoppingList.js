/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
modit('app.view', function() {
  function shoppingList(div) {
    var list = $('<li>');
    var items = $.get('menus/6.json');
    _.each(items, function(item) {
      list.append($('<li>').addClass('shopping-list-item'));
    });
    div.append(list);
  }
  this.exports(shoppingList);
});

modit('app.view', function() {
  function shoppingList(div) {
    var list = $('<ul>');
    var menu = $.getJSON('menus/6.json');
    _.each(menu.ingredients, function(item) {
      list
        .append($('<li>')
          .append($('<div>')
            .addClass('shopping-list-item')
            .text(item.quantity + " " + item.unit + " " + item.name)
          )
        );
    });
    div.append(list);
  }
  this.exports(shoppingList);
});
