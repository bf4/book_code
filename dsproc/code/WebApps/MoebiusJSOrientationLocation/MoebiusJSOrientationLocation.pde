/**
 * <p>Ketai Sensor Library for Android: http://ketaiProject.org</p>
 *
 * <p>Updated: 2012-10-14 Daniel Sauter/Jesus Duran</p>
 */

PVector location = new PVector();  //(1)
PVector orientation = new PVector();  //(2)

ArrayList<PVector> points = new ArrayList<PVector>();  
void setup()
{
  size(480, 800, P3D);

  noStroke();
  int sections = 360;

  for (int i=0; i<=sections; i++)
  {
    pushMatrix();
    rotateZ(radians(map(i, 0, sections, 0, 360)));
    pushMatrix();
    translate(width/3, 0, 0); 
    pushMatrix();
    rotateY(radians(map(i, 0, sections, 0, 180)));
    points.add(
      new PVector(modelX(0, 0, 50), modelY(0, 0, 50), modelZ(0, 0, 50))
    );
    points.add(
      new PVector(modelX(0, 0, -50), modelY(0, 0, -50), modelZ(0, 0, -50))
    );
    popMatrix();
    popMatrix();
    popMatrix();
  }
}

void draw()
{
  background(0);
  ambientLight(0, 0, 128);
  pointLight(255, 255, 255, 0, 0, 0);

  translate(width/2, height/2, 0);
  rotateX(orientation.x);
  rotateY(orientation.y);
  rotateZ(orientation.z);

  beginShape(QUAD_STRIP);
  for (int i=0; i<points.size(); i++)
  {
    vertex(points.get(i).x, points.get(i).y, points.get(i).z);
  }
  endShape(CLOSE);
  if (frameCount%100 == 0)
    println("Latitude: " + location.x + " | Longitude: " + location.y);
}

void orientationEvent ( float ox, float oy, float oz)  //(3)
{
  orientation.set(ox, oy, oz);  //(4)
}

void locationEvent(float lat, float lon)  //(5)
{
   location.set(lat, lon);  //(6)
}
