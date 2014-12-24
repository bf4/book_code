/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
$(function() {
  var BAUD_RATE = 9600;
  var remote = new SerialDevice("/dev/tty.usbmodem24311", BAUD_RATE);

  remote.onConnect.addListener(function() {
    console.log("Connected to: " + remote.path);
  });

  remote.connect();

  $("[type=button]").on("click", function(event){
    var buttonType = $(event.currentTarget).attr("id"); 
    console.log("Button pressed: " + buttonType);
    remote.send(buttonType + "\n");
  });
});

