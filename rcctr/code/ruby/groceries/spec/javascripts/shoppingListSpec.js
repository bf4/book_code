/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
/*
describe('Shopping List', function() {
  var app;

  beforeEach(function() {
    app = require('specHelper');
  });

  
  it('displays the items collected from the menu', function() {
    window.location = 'menus/6';
    var div = $('<div>');
    spyOn(jQuery, 'getJSON').andReturn([{}, {}]);

    app.view.shoppingList(div);

    expect(div.find('.shopping-list-item').length).toEqual(2);
    expect(jQuery.getJSON).wasCalled();
  });
});
*/

describe('Shopping List', function() {
  var response, app;

  beforeEach(function() {
    app = require('specHelper');
    response = {
      ingredients: [
        {
          needed: true,
          quantity: "1",
          unit: "loaf",
          name: "Sourdough Bread"
        },
        {
          needed: false,
          quantity: "2/3",
          unit: "cup",
          name: "milk"
        }
      ]
    };
  });

  it('displays the items collected from the menu', function() {
    window.location = 'menus/6';
    var div = $('<div>');
    spyOn(jQuery, 'getJSON').andReturn(response);
    
    app.view.shoppingList(div);
    
    items = div.find('.shopping-list-item');
    expect(items.length).toEqual(2);
    expect(items.first().text()).toEqual('1 loaf Sourdough Bread');
    expect(jQuery.getJSON).wasCalledWith('menus/6.json');
  });
});
