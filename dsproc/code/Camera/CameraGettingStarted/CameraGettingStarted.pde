/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Camera Features:
 * <ul>
 * <li>Interface for built-in camera</li>
 * <li></li>
 * </ul>
 * <p>Updated: 2012-03-10 Daniel Sauter/j.duran</p>
 */

import ketai.camera.*;
KetaiCamera cam;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 640, 480, 30);  //(1)
  imageMode(CENTER);  //(2)
}

void draw() {
  if (cam.isStarted()) 
    image(cam, width/2, height/2);  //(3)
}

void onCameraPreviewEvent() {  //(4)
  cam.read();  //(5)
}

void mousePressed() {
  if (cam.isStarted())
  {
    cam.stop();  //(6)
  }
  else
    cam.start();
}

