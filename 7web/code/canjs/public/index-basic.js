/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
$(document).ready(function() {
  // Use can for CanJS
  var $result = $("#result");
  can.each(["One", "Two", "Three"], function(it) {
    $result.append(it).append(", ");
  });
  $result.append("Go CanJS!");
});
