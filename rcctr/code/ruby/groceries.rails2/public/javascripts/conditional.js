/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
modit('app.storage', function() {
  function saveCookie(item) {
    //save item to a cookie
    //... 
  }

  function saveLocal(item) {
    // save item to HTML5 local storage
    //...
  }
  this.exports(saveCookie);

  if (typeof(localStorage) !== ‘undefined’ ) {
    this.exports(saveLocal);
  } 
});

modit('app', ['app.storage'], function(storage) {
  function saveItems(items) {
    _.each(items, storage.saveLocal || storage.saveCookie);
  }
});
