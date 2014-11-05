/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
var lastTouchedElement;
$('html').live('click', function(event) {
  lastTouchedElement = event.target;
});

function doNotTrackClicks() {
  return navigator.userAgent.match(/iPhone|iPad/i);
}
$('navbar.dropdown > ul > li').live('click', function(event) {
  if (!(doNotTrackClicks() || lastTouchedElement == event.target)) {
    event.preventDefault();
  }
  lastTouchedElement = event.target;
});

$('navbar.dropdown li').live('click', function(event) {
  event.stopPropagation();
});
