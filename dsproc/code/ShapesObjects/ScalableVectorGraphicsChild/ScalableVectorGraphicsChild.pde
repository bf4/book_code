import ketai.ui.*;
import android.view.MotionEvent;

KetaiGesture gesture;
PShape us;
String tossups[] = { 
  "co", "fl", "ia", "nh", "nv", "oh", "va", "wi" //(1)
};
PShape[] tossup = new PShape[tossups.length];  //(2)
float scaleFactor = 1;
int x, y;  

void setup() {
  orientation(LANDSCAPE);
  gesture = new KetaiGesture(this);

  us = loadShape("Blank_US_map_borders.svg");
  shapeMode(CENTER);
  for (int i=0; i<tossups.length; i++)
  {
    tossup[i] = us.getChild(tossups[i]);  //(3)
    tossup[i].disableStyle();  //(4)
  }
  x = width/2;
  y = height/2;
}
void draw() {
  background(128);
  
  translate(x, y);  //(5)
  scale(scaleFactor);  //(6)
  
  shape(us);
  for (int i=0; i<tossups.length; i++)
  {
    fill(128, 0, 128);  //(7)
    shape(tossup[i]);  //(8)
  }
}
void onPinch(float x, float y, float d)  //(9)
{
  scaleFactor += d/100;
  scaleFactor = constrain(scaleFactor, 0.1, 10);
  println(scaleFactor);
}
void mouseDragged()  //(10)
{
  if (abs(mouseX - pmouseX) < 50) 
    x += mouseX - pmouseX;
  if (abs(mouseY - pmouseY) < 50) 
    y += mouseY - pmouseY;
}
public boolean surfaceTouchEvent(MotionEvent event) {
  super.surfaceTouchEvent(event);
  return gesture.surfaceTouchEvent(event);
}

