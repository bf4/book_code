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
float rotationX, rotationY, rotationZ;
float roll, pitch, yaw;

void setup()
{
  size(displayWidth, displayHeight, P3D);
  orientation(PORTRAIT);

  sensor = new KetaiSensor(this);
  sensor.start();
} 

void draw() 
{
  background(0);
  lights();

  pitch += rotationX;
  roll += rotationY;
  yaw += rotationZ;
  
  translate( width/2, height/2 );
  rotateX(pitch);
  rotateY(-roll);
  rotateZ(yaw);

  float radius = width/3;
  beginShape(QUAD_STRIP);
  for (int i =0; i <= 360; i+= 10) {
    float x = sin(radians( i )) * radius/5;   
    float z = cos(radians( i )) * radius/5;

    float x1 = (radius + x) * sin(radians(i * 2));
    float y1 = (radius + x) * cos(radians(i * 2));
    vertex(x1, y1, z);

    float x2 = (radius - x) * sin(radians(i * 2));
    float y2 = (radius - x) * cos(radians(i * 2));
    vertex(x2, y2, -z);
  }
  endShape(CLOSE);

  if (frameCount % 10 == 0)
    println(frameRate);
}

void onGyroscopeEvent(float x, float y, float z)
{
  rotationX = radians(x);
  rotationY = radians(y);
  rotationZ = radians(z);
}

void mousePressed()
{
    pitch = roll = yaw = 0;
}

