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

void drawUI() {
  fill(0, 128);
  rect(0, 0, width/4, 40);
  rect(width/4, 0, width/4, 40);
  rect(2*(width/4), 0, width/4, 40);
  rect(3*(width/4), 0, width/4-1, 40);

  fill(255);
  if (cam.isStarted())
    text("stop", 10, 30);
  else
    text("start", 10, 30);

  text("camera", (width/4)+10, 30);
  text("flash", 2*(width/4)+ 10, 30);
  text("save", 3*(width/4)+10, 30); //(1)
}

void mousePressed() {
  if (mouseY <= 40) {
    if (mouseX > 0 && mouseX < width/4)
    {
      if (cam.isStarted())
      {
        cam.stop();
      }
      else
      {
        if (!cam.start())
          println("Failed to start camera.");
      }
    }
    else if (mouseX > width/4 && mouseX < 2*(width/4))
    {
      int cameraID = 0;
      if (cam.getCameraID() == 0)
        cameraID = 1;
      else
        cameraID = 0;
      cam.stop();
      cam.setCameraID(cameraID);
      cam.start();
    }
    else if (mouseX >2*(width/4) && mouseX < 3*(width/4))
    {
      if (cam.isFlashEnabled())
        cam.disableFlash();
      else
        cam.enableFlash();
    }
    else if (mouseX > 3*(width/4) && mouseX < width) //(2)
    {
      if (cam.isStarted()) cam.savePhoto(); //(3)
    }
  }
}

void onSavePhotoEvent(String filename) //(4)
{
  cam.addToMediaLibrary(filename); //(5)
}

void onCameraPreviewEvent()
{
  cam.read();
}

