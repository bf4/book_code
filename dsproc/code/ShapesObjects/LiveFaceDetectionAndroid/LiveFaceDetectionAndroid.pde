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

int MAX_FACES = 1;
KetaiSimpleFace[] faces = new KetaiSimpleFace[MAX_FACES];
KetaiCamera cam;
PVector camLocation = new PVector();  //(1)
PShape sphereShape;  
PImage sphereTexture;  

void setup() {
  size(displayWidth, displayHeight, P3D);
  orientation(LANDSCAPE);
  stroke(255, 50);
  sphereTexture = loadImage("earth_lights_lrg.jpg"); 
  sphereDetail(36);  //(2)
  sphereShape = createShape(SPHERE, height/2);  
  sphereShape.texture(sphereTexture);  

  cam = new KetaiCamera(this, 320, 240, 24);
  cam.setCameraID(1);
}

void draw() {
  if (cam.isStarted())
    background(50);
  else
    background(0);
  translate(width/2, height/2, 0);
  camera(camLocation.x, camLocation.y, height, // eyeX, eyeY, eyeZ    //(3)
  0.0, 0.0, 0.0, // centerX, centerY, centerZ
  0.0, 1.0, 0.0); // upX, upY, upZ
  noStroke();
  faces = KetaiFaceDetector.findFaces(cam, MAX_FACES);   //(4)

  for (int i=0; i < faces.length; i++) {
    //reverse the "face-mapping" correcting mirrored camera image
    camLocation.x = map(faces[i].location.x, 0, cam.width, width/2, -width/2);   //(5)
    camLocation.y = map(faces[i].location.y, 0, cam.height, -height/2, height/2);  //(6)
  }
  
  if (!cam.isStarted()) {
    camLocation.x = map(mouseX, 0, width, -width/2, width/2);  //(7)
    camLocation.y = map(mouseY, 0, height, -height/2, height/2);
  }
  shape(sphereShape);

  fill(255);
  rotateY(PI * frameCount / 500);  //(8)
  translate(0, 0, -height/2 / 3.7 * 2 * 110); //(9)
  sphere(height/2 / 3.7); //(10)
}

void onCameraPreviewEvent() {
  cam.read();
}
void exit() {
  cam.stop();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == MENU) { //(11)
      if (cam.isStarted()) {
        cam.stop();
      }
      else
        cam.start();
    }
  }
}

