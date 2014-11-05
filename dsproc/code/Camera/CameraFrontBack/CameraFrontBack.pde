/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Camera Features:
 * <ul>
 * <li>Interface for built-in camera</li>
 * <li></li>
 * </ul>
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */

import ketai.camera.*;

KetaiCamera cam;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 640, 480, 30);
  println(cam.list()); //(1)
  // 0: back camera; 1: front camera
  cam.setCameraID(0); //(2)
  imageMode(CENTER);
  stroke(255);
  textSize(24); //(3)
}

void draw() {
  image(cam, width/2, height/2);
  drawUI(); //(4)
}

