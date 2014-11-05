/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
modit('app.example.view', function() {
  function updatedAt(recipes) {
    return "Last updated at " + app.example.time.format(recipe.updateTime, app.example.time.SHORT);
  }
  this.exports(updatedAt);
});

modit('app.example.view', ['app.example.time'], function(time) {
  function updatedAt(recipe) {
    return "Last updated at " + time.format(recipe.updateTime, time.SHORT);
  }
  this.exports(updatedAt);
});
