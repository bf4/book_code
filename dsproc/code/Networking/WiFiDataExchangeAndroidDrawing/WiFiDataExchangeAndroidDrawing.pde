/**
 * <p>OSC Send/Receive</p>
 *
 * <p>OSC Features:
 * <ul>
 * <li>data exchange via OSC</li>
 * <li>sends and receives OSC messages</li>
 * </ul>
 * More information at http://www.sojamo.de/oscP5</p>
 * <p>KetaiSensor Features:
 * <ul>
 * <li>handles accelerometer sendor events</li>
 * </ul>
 * More information at http://ketaiProject.com</p>
 * <p>Updated: 2012-01-29 Daniel Sauter/j.duran</p>
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
int x, y, px, py;

void setup() {
  orientation(PORTRAIT);
  oscP5 = new OscP5(this, 12001);  
  remoteLocation = new NetAddress("10.0.1.66", 12001); //(1)
  background(78, 93, 75);
}

void draw() {
  stroke(0);
  float remoteSpeed = dist(px, py, x, y);  //(2)
  strokeWeight(remoteSpeed);  //(3)
  if (remoteSpeed < 50) line(px, py, x, y);  //(4)
  px = x;  //(5)
  py = y;  //(6)
  if (mousePressed) {
    stroke(255);
    float speed = dist(pmouseX, pmouseY, mouseX, mouseY); //(7)
    strokeWeight(speed);  //(8)
    if (speed < 50) line(pmouseX, pmouseY, mouseX, mouseY);  //(9)
    OscMessage myMessage = new OscMessage("AndroidData"); 
    myMessage.add(mouseX); 
    myMessage.add(mouseY);
    oscP5.send(myMessage, remoteLocation);
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("ii"))  
  {
    x =  theOscMessage.get(0).intValue();
    y =  theOscMessage.get(1).intValue();
  }
}
