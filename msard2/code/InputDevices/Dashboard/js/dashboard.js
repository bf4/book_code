/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
var arduino = new SerialDevice("/dev/tty.usbmodem24321", 9600);

arduino.onConnect.addListener(function() {
  console.log("Connected to: " + arduino.path);
});

arduino.onReadLine.addListener(function(line) {
  console.log("Read line: " + line);
  var attr = line.split(","); 
  if (attr.length == 2) {
    var temperature = Math.round(parseInt(attr[0]) / 100.0 * 10) / 10; 
    var distance = parseInt(attr[1]) / 100.0;
    updateUI(temperature, distance);
  }
});

var lights = {
  d1: [35.0, "orange"],
  d2: [30.0, "orange"],
  d3: [25.0, "orange"],
  d4: [20.0, "orange"],
  d5: [15.0, "orange"],
  d6: [10.0, "orange"],
  d7: [7.0, "red"],
  d8: [5.0, "red"]
};

function updateUI(temperature, distance) {
  document.getElementById("temperature").innerText = temperature; 
  for (var i = 1; i < 9; i++) { 
    var index = "d" + i; 
    if (distance <= lights[index][0])
      document.getElementById(index).style.color = lights[index][1];
    else
      document.getElementById(index).style.color = "white";
  }
}

arduino.connect();

