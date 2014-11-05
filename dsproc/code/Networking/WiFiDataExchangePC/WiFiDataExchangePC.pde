/**
 * <p>OSC Send/Receive</p>
 *
 * <p>Based on oscP5sendreceive by andreas schlegel
 * More information at http://www.sojamo.de/oscP5</p>
 * <p>Updated: 2012-01-29 Daniel Sauter/j.duran</p>
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;

void setup() {
  size(480, 480);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("10.0.1.51", 12000); //(1) Customize!
  textAlign(CENTER, CENTER);
  textSize(24);
}

void draw() {
  background(78, 93, 75);
  text("Remote Accelerometer Info: " + "\n" +
    "x: "+ nfp(accelerometerX, 1, 3) + "\n" +
    "y: "+ nfp(accelerometerY, 1, 3) + "\n" +
    "z: "+ nfp(accelerometerZ, 1, 3) + "\n\n" +
    "Local Info: \n" + 
    "mousePressed: " + mousePressed, width/2, height/2);

  OscMessage myMessage = new OscMessage("mouseStatus");
  myMessage.add(mouseX);  //(2)
  myMessage.add(mouseY);  //(3)
  myMessage.add(int(mousePressed)); //(4)
  oscP5.send(myMessage, remoteLocation); //(5)
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("fff"))  //(6)
  {
    accelerometerX =  theOscMessage.get(0).floatValue(); //(7)
    accelerometerY =  theOscMessage.get(1).floatValue();
    accelerometerZ =  theOscMessage.get(2).floatValue();
  }
}

