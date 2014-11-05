/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
var applyColorPicker = function(){
  $('input[type=color]').simpleColor();
};

Modernizr.load(
  {
    test: Modernizr.color,
    nope: "javascripts/jquery.simple-color.js",
    callback: function(url, result){
      if (!result){
        applyColorPicker();
      }
    }
  }
);


if (!Modernizr.autofocus){
  $('input[autofocus]').focus();
}
