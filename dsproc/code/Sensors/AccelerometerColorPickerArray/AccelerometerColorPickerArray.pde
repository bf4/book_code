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
float r, g, b;
int num = 8;  //(1)
color[] palette = new color[num];  //(2)
int paletteIndex = 0;  //(3)

void setup() {
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(36);
}

void draw() {
  // remap sensor values to color range  
  r = map(accelerometerX, -10, 10, 0, 255);
  g = map(accelerometerY, -10, 10, 0, 255);
  b = map(accelerometerZ, -10, 10, 0, 255);
  // assign color to background 
  background(r, g, b);
  fill(0);
  text("Current Color: \n" + 
    "(" + round(r) + ", " + round(g) + ", " + round(b) + ")", //(4)
  width*0.5, height*0.25);
  // color picker
  for (int i=0; i<num; i++) {  //(5)
    fill(palette[i]);  //(6)
    rect(i*width/num, height/2, width/num, height/2); //(7)
  }
}
void onAccelerometerEvent(float x, float y, float z) {
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}
void mousePressed() {
  // updating color value, tapping top half of the screen
  if (mouseY < height/2) {
    palette[paletteIndex] = color(r, g, b);  //(8)
    if (paletteIndex < num-1) {
      paletteIndex++;  //(9)
    } 
	
    else {
      paletteIndex = 0;  //(10)
    }
  }
}

