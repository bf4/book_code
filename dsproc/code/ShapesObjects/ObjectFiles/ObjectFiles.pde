import ketai.ui.*;
import android.view.MotionEvent;

KetaiGesture gesture;

PShape wtc;
int r, y;
float scaleFactor = .02;

void setup() {
  size(displayWidth, displayHeight, P3D);
  orientation(PORTRAIT);
  gesture = new KetaiGesture(this);
  noStroke();

  wtc = loadShape("OneWTC.obj");  //(1)
  y = height/4*3;
}

void draw() {
  background(0);
  lights();  //(2)
  
  translate(width/2, y);  //(3)
  scale(scaleFactor);  //(4)
  rotateX(PI);  //(5)
  rotateY(radians(r));  //(6)
  
  shape(wtc);  //(7)
}

void onPinch(float x, float y, float d)  //(8)
{
  scaleFactor += d/5000;
  scaleFactor = constrain(scaleFactor, 0.01, .3);
  println(scaleFactor);
}

void mouseDragged()  //(9)
{
  if (abs(mouseX - pmouseX) < 50) 
    r += mouseX - pmouseX;
  if (abs(mouseY - pmouseY) < 50) 
    y += mouseY - pmouseY;
}

public boolean surfaceTouchEvent(MotionEvent event) {
  super.surfaceTouchEvent(event);
  return gesture.surfaceTouchEvent(event);
}

