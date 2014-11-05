/**
 * <p>Updated: 2012-01-29 Daniel Sauter/j.duran</p>
 *
 * <p>Based on oscP5sendreceive by andreas schlegel
 * More information at http://www.sojamo.de/oscP5</p>
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
int x, y, px, py;

void setup() {
  size(480, 800);
  oscP5 = new OscP5(this, 12001);
  remoteLocation = new NetAddress("10.0.1.41", 12001); //(1)
  background(78, 93, 75);
}

void draw() {
  stroke(0);
  float remoteSpeed = dist(px, py, x, y);
  strokeWeight(remoteSpeed);  
  if (remoteSpeed < 50) line(px, py, x, y); 
  px = x; 
  py = y;  
  if (mousePressed) {
    stroke(255);
    float speed = dist(pmouseX, pmouseY, mouseX, mouseY); 
    strokeWeight(speed);
    if (speed < 50) line(pmouseX, pmouseY, mouseX, mouseY); 
    OscMessage myMessage = new OscMessage("PCData"); 
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

