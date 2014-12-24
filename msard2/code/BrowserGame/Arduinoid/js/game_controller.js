/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
var GameController = function(path, threshold) {
  this.arduino = new SerialDevice(path);
  this.threshold = threshold || 325;
  this.moveLeft = false;
  this.moveRight = false;
  this.buttonPressed = false;
  this.boundOnReadLine = this.onReadLine.bind(this);
  this.arduino.onReadLine.addListener(this.boundOnReadLine);
  this.arduino.connect();
}

GameController.prototype.onReadLine = function(line) {
  const TOLERANCE = 5;
  var attr = line.trim().split(' ');
  if (attr.length == 4) {
    this.moveRight = false;
    this.moveLeft = false;
    var x = parseInt(attr[0]);
    if (x <= this.threshold - TOLERANCE) {
      this.moveLeft = true;
    } else if (x >= this.threshold + TOLERANCE) {
      this.moveRight = true;
    }

    this.buttonPressed = (attr[3] == '1');
  }
}

