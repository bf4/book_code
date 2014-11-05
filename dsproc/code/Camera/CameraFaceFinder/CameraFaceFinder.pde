/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Camera Features:
 * <ul>
 * <li>Interface for built-in camera</li>
 * <li>Uses Androids FaceAnalyzer API</li>
 * </ul>
 * <p>Updated: 2012-02-09 Daniel Sauter/j.duran</p>
 */
import ketai.camera.*;
import ketai.cv.facedetector.*;
KetaiCamera cam;
KetaiSimpleFace[] faces;  //(1)
boolean findFaces = false;
void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 640, 480, 24);
  rectMode(CENTER);  //(2)
  stroke(0, 255, 0);
  noFill();  //(3)
}

void draw() {
  background(0); 
  if (cam != null) {
    image(cam, 0, 0, 640, 480);
    if (findFaces)  //(4)
    {
      faces = KetaiFaceDetector.findFaces(cam, 20);  //(5)
      for (int i=0; i < faces.length; i++)  //(6)
      {
        rect(faces[i].location.x, faces[i].location.y, //(7)
        faces[i].distance*2, faces[i].distance*2);  //(8)
      }
      text("Faces found: " + faces.length, 680, height/2);  //(9)
    }
  }
}

void mousePressed () {
  if(!cam.isStarted())
    cam.start();
  if (findFaces)
    findFaces = false;
  else 
    findFaces = true;
}
void onCameraPreviewEvent() {
  cam.read();
}
