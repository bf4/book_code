/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Camera Features:
 * <ul>
 * <li>Interface for built-in camera</li>
 * <li>Saves Images to the Gallery</li>
 * </ul>
 * <p>Updated: 2012-03-22 Daniel Sauter/j.duran</p>
 */

import ketai.camera.*;

KetaiCamera cam;
PImage bg, snapshot, mux;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 720, 480, 30);
  cam.setCameraID(1);  //(1)
  imageMode(CENTER);
  stroke(255);
  textSize(24);
  snapshot = createImage(720, 480, RGB);
  bg = loadImage("rover.jpg");  //(2)
  bg.resize(720, 480);
  bg.loadPixels();
//  mux = new PImage(640, 480);
  mux = new PImage(720, 480);
}

void draw() {
  background(0);
  if (cam.isStarted()) {    
    cam.loadPixels();  //(3)
    snapshot.loadPixels();  //(4)
    mux.loadPixels();  //(5)
    for (int i= 0; i < cam.pixels.length; i++)
    {  
      color currColor = cam.pixels[i];  //(6)
      float currR = abs(red(cam.pixels[i]) - red(snapshot.pixels[i]) );  //(7)
      float currG = abs(green(cam.pixels[i]) - green(snapshot.pixels[i]));
      float currB = abs(blue(cam.pixels[i]) - blue(snapshot.pixels[i]));      
      float total = currR+currG+currB;  //(8)
      if (total < 128)
        mux.pixels[i] = bg.pixels[i];  //(9)        
      else
        mux.pixels[i] = cam.pixels[i];  //(10)
    }
    mux.updatePixels();  //(11)
    image(mux, width/2, (height-40)/2);  //(12)
  } 
  drawUI();
}

