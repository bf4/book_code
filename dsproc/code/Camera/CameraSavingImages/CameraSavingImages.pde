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

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 640, 480, 24);
  println(cam.list());
  // 0: back camera; 1: front camera
  cam.setCameraID(0);
  imageMode(CENTER);
  stroke(255);
  textSize(24);
}

void draw() { 
  background(128);
  if (!cam.isStarted()) //(1)
  {
    pushStyle(); //(2)
    textAlign(CENTER, CENTER);
    String info = "CameraInfo:\n";
    info += "current camera: "+ cam.getCameraID()+"\n"; //(3)
    info += "image dimensions: "+ cam.width + //(4)
      "x"+cam.height+"\n";     //(5)
    info += "photo dimensions: "+ cam.getPhotoWidth() + //(6)
      "x"+cam.getPhotoHeight()+"\n"; //(7)
    info += "flash state: "+ cam.isFlashEnabled()+"\n"; //(8)
    text(info, width/2, height/2); 
    popStyle(); //(9)
  }
  else
  {
    image(cam, width/2, height/2);
  }
  drawUI();
}



