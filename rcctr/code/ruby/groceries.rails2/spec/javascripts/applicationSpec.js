/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
describe('Groceries App', function() {
  var app;
  beforeEach(function() {
    app = require('specHelper');
  });

  it('loads on startup', function() {
    expect(app.start).toBeDefined();
  });
  it('uses JQuery', function() {
    expect($('body').size()).toEqual(1);
  });

  it('has a title bar', function() {
    app.start();
    expect($('#titlebar').size()).toEqual(1);
  });

  it('User can hide the title bar by clicking on it', function() {
    app.start();

    // May be inconsistent because starting the app again created two title bars!
    $('#titlebar').click();

    expect($('#titlebar:visible').length).toEqual(0);
  });

  it('creates the shopping list on startup', function() {
    spyOn(app.view, 'shoppingList').andReturn();
    $('body').append($("<div>").attr('id', 'shopping-list'));

    app.start();

    expect(app.view.shoppingList).wasCalled();
  });
});
