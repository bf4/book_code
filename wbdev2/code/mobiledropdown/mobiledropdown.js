/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
var lastTouchedElement;
$('html').on('click', function(event) {
  lastTouchedElement = event.target;
});

function doNotTrackClicks() {
  return navigator.userAgent.match(/iPhone|iPad/i);
}
$('nav.dropdown > ul').on('click', '> li', function(event) {
  if (!(doNotTrackClicks() || lastTouchedElement == event.target)) {
    event.preventDefault();
  }
  lastTouchedElement = event.target;
});

$('nav.dropdown').on('click', 'li', function(event) {
  event.stopPropagation();
});
