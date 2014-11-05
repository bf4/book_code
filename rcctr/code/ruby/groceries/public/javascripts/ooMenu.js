/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
MenuController = function(items) {

  this.listenTo = function(div) {
    div.onclick(function(e) {
      items.push(e.element.text());
    });
  };
};
