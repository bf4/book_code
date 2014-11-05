/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Camera Features:
 * <ul>
 * <li>Interface for built-in camera</li>
 * </ul>
 * <p>Updated: 2012-03-22 Daniel Sauter/j.duran</p>
 */

import ketai.camera.*;

KetaiCamera cam;
PImage container;
int low = 30; 
int high = 100;
int camWidth = 320;
int camHeight = 240;
int redScore, blueScore = 0;
int win = 0;

void setup() {
  orientation(LANDSCAPE);
  imageMode(CENTER);
  cam = new KetaiCamera(this, camWidth, camHeight, 30);
  // 0: back camera; 1: front camera
  cam.setCameraID(1);
  container = createImage(camWidth, camHeight, RGB);  //(1)
}

void draw() {
  if (win == 0) background(0);
  if (cam.isStarted()) {
    cam.loadPixels();
    float propWidth = height/camHeight*camWidth;  //(2)
    if (win == 0) image(cam, width/2, height/2, propWidth, height);  //(3)
    for (int y = 0; y < cam.height; y++) {
      for (int x = 0; x < cam.width; x++) {
        color pixelColor = cam.get(x, y);  //(4)
        if (red(pixelColor) > high && 
          green(pixelColor) < low && blue(pixelColor) < low) {  //(5)
          if (brightness(container.get(x, y)) == 0) {   //(6)
            container.set(x, y, pixelColor);
            redScore++;
          }
        }
        if (blue(pixelColor) > high && 
          red(pixelColor) < low && green(pixelColor) < low) {  //(7)
          if (brightness(container.get(x, y)) == 0) {  
            container.set(x, y, pixelColor);
            blueScore++;
          }
        }
      }
    }
    image(container, width/2, height/2, propWidth, height);  //(8)
    fill(255, 0, 0);
    rect(0, height, 20, map(redScore, 0, camWidth*camHeight, 0, -height));
    fill(0, 0, 255);
    rect(width-20, height, 20, map(blueScore, 0, camWidth*camHeight, 0, -height));
    if (redScore+blueScore >= camWidth*camHeight * 0.50) {  //(9)
      win++;
      if (redScore > blueScore) {  //(10)
        fill(255, 0, 0, win);
      } 
      else {
        fill(0, 0, 255, win);
      } 
      rect(0, 0, width, height);
    }
    if (win >= 50) {
      container.loadPixels();  //(11)
      for (int i = 0; i < container.pixels.length; i++) {
        container.pixels[i] = color(0, 0, 0, 0); //(12)
        redScore = blueScore = win = 0;
      }
    }
  }
}

void mousePressed()
{
   if(cam.isStarted())
      cam.stop();
   else
     cam.start();
}
