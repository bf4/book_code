/**
 * <p>Ketai Sensor Library for Android: http://ketaiMotion.org</p>
 *
 * <p>KetaiSensor Features:
 * <ul>
 * <li>handles incoming Sensor Events</li>
 * <li>Includes Accelerometer, Magnetometer, Gyroscope, GPS, Light, Proximity</li>
 * </ul>
 * <p>Updated: 2011-11-25 Daniel Sauter/Jesus Duran</p>
 */

import ketai.sensors.*;

KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;
color swatch;  //(1)
float r, g, b;

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(36);
}

void draw()
{
  // remap sensor values to color range  
  r = map(accelerometerX, -10, 10, 0, 255);
  g = map(accelerometerY, -10, 10, 0, 255);
  b = map(accelerometerZ, -10, 10, 0, 255);
  // assign color to background 
  background(r, g, b);
  // color picker
  fill(swatch);  //(2)
  rect(0, height/2, width, height/2);  //(3)
  fill(0);
  text("Picked Color: \n" + 
    "r: " + red(swatch) + "\n" + //(4)
    "g: " + green(swatch) + "\n" +
    "b: " + blue(swatch), width*0.5, height*0.75);
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

void mousePressed() 
{
  // updating color value, tapping top half of the screen
  if (mouseY < height/2)
    swatch = color(r, g, b);  //(5)
}

