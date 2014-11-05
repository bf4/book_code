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

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER); 
  textSize(36); 
}

void draw() {
  float r = map(accelerometerX, -10, 10, 0, 255);
  float g = map(accelerometerY, -10, 10, 0, 255);
  float b = map(accelerometerZ, -10, 10, 0, 255);
  background(r, g, b);
  text("Accelerometer: \n" + 
    "x: " + nfp(accelerometerX, 2, 3) + "\n" +
    "y: " + nfp(accelerometerY, 2, 3) + "\n" +
    "z: " + nfp(accelerometerZ, 2, 3), width/2, height/2);
}

void onAccelerometerEvent(float x, float y, float z) {
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

