/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
/*
 * This file is based on one of the Chrome App samples
 * (https://github.com/GoogleChrome/chrome-app-samples/tree/master/samples/serial/ledtoggle).
 * The original file is licensed under the Apache 2.0 license. You can find a
 * copy of the license in ../LICENSE-2.0.txt.
 */

var SerialDevice = function(path, baudRate) {
  this.path = path;
  this.baudRate = baudRate || 38400;
  this.connectionId = -1;
  this.readBuffer = "";
  this.boundOnReceive = this.onReceive.bind(this);
  this.boundOnReceiveError = this.onReceiveError.bind(this);
  this.onConnect = new chrome.Event();
  this.onReadLine = new chrome.Event();
  this.onError = new chrome.Event();
};

SerialDevice.prototype.onConnectComplete = function(connectionInfo) {
  if (!connectionInfo) {
    console.log("Could not connect to serial device.");
    return;
  }
  this.connectionId = connectionInfo.connectionId;
  chrome.serial.onReceive.addListener(this.boundOnReceive);
  chrome.serial.onReceiveError.addListener(this.boundOnReceiveError);
  this.onConnect.dispatch();
};

SerialDevice.prototype.onReceive = function(receiveInfo) {
  if (receiveInfo.connectionId !== this.connectionId) {
    return;
  }

  this.readBuffer += this.arrayBufferToString(receiveInfo.data);

  var n;
  while ((n = this.readBuffer.indexOf('\n')) >= 0) {
    var line = this.readBuffer.substr(0, n + 1);
    this.onReadLine.dispatch(line);
    this.readBuffer = this.readBuffer.substr(n + 1);
  }
};

SerialDevice.prototype.onReceiveError = function(errorInfo) {
  if (errorInfo.connectionId === this.connectionId) {
    this.onError.dispatch(errorInfo.error);
  }
};

SerialDevice.prototype.connect = function() {
  chrome.serial.connect(this.path, { bitrate: this.baudRate }, this.onConnectComplete.bind(this))
};

SerialDevice.prototype.send = function(data) {
  if (this.connectionId < 0) {
    throw 'No serial device connected.';
  }
  chrome.serial.send(this.connectionId, this.stringToArrayBuffer(data), function() {});
};

SerialDevice.prototype.disconnect = function() {
  if (this.connectionId < 0) {
    throw 'No serial device connected.';
  }
  chrome.serial.disconnect(this.connectionId, function() {});
};

SerialDevice.prototype.arrayBufferToString = function(buf) {
  var bufView = new Uint8Array(buf);
  var encodedString = String.fromCharCode.apply(null, bufView);
  return decodeURIComponent(escape(encodedString));
};

SerialDevice.prototype.stringToArrayBuffer = function(str) {
  var encodedString = unescape(encodeURIComponent(str));
  var bytes = new Uint8Array(encodedString.length);
  for (var i = 0; i < encodedString.length; ++i) {
    bytes[i] = encodedString.charCodeAt(i);
  }
  return bytes.buffer;
};

