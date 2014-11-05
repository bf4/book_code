/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai UI Gesture Features:
 * <ul>
 * <li>Detect Double Tap using onDoubleTap()</li>
 * <li>Detect Single Tap using onTap()</li>
 * <li>Detect Long Press using onLongPress()</li>
 * <li>Detect Flick using onFlick()</li>
 * <li>Detect Pinch using onPinch()</li>
 * <li>Detect Rotate using onRotate()</li>
 * </ul>
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */

import ketai.ui.*;  //(1)
import android.view.MotionEvent;  //(2)

KetaiGesture gesture;  //(3)
float rectSize = 100;  //(4)
float rectAngle = 0;  
int x, y;
color c = color(255);  //(5)
color bg = color(78, 93, 75);  //(6)

void setup()
{
  orientation(LANDSCAPE);
  gesture = new KetaiGesture(this);  //(7)

  textSize(32);
  textAlign(CENTER, BOTTOM);
  rectMode(CENTER);
  noStroke();

  x = width/2;  //(8)
  y = height/2; //(9)
}

void draw()
{
  background(bg);
  pushMatrix();  //(10)
  translate(x, y);  //(11)
  rotate(rectAngle);
  fill(c);
  rect(0, 0, rectSize, rectSize);
  popMatrix();  //(12)
}

void onTap(float x, float y)  //(13)
{
  text("SINGLE", x, y-10);
  println("SINGLE:" + x + "," + y);
}

void onDoubleTap(float x, float y)  //(14)
{
  text("DOUBLE", x, y-10);
  println("DOUBLE:" + x + "," + y);

  if (rectSize > 100)
    rectSize = 100;
  else
    rectSize = height - 100;
}

void onLongPress(float x, float y)  //(15)
{
  text("LONG", x, y-10);
  println("LONG:" + x + "," + y);

  c = color(random(255), random(255), random(255));
}

void onFlick( float x, float y, float px, float py, float v)  //(16)
{
  text("FLICK", x, y-10);
  println("FLICK:" + x + "," + y + "," + v);

  bg = color(random(255), random(255), random(255));
}
void onPinch(float x, float y, float d)  //(17)
{
  rectSize = constrain(rectSize+d, 10, 500);
  println("PINCH:" + x + "," + y + "," + d);
}

void onRotate(float x, float y, float angle)  //(18)
{
  rectAngle += angle;
  println("ROTATE:" + angle);
}

void mouseDragged()  //(19)
{
  if (abs(mouseX - x) < rectSize/2 && abs(mouseY - y) < rectSize/2)
  {
    if (abs(mouseX - pmouseX) < rectSize/2) 
      x += mouseX - pmouseX;
    if (abs(mouseY - pmouseY) < rectSize/2) 
      y += mouseY - pmouseY;
  }
}

public boolean surfaceTouchEvent(MotionEvent event) {  //(20)
  //call to keep mouseX and mouseY constants updated
  super.surfaceTouchEvent(event);
  //forward events
  return gesture.surfaceTouchEvent(event);
}

