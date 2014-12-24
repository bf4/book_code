/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
var arduino = new SerialDevice('/dev/tty.usbmodem24311');

arduino.onConnect.addListener(function() {
  console.log('Connected to: ' + arduino.path);
});

arduino.onReadLine.addListener(function(line) {
  console.log('Read line: ' + line);
  document.getElementById('output').innerText = line;
});

arduino.connect();
