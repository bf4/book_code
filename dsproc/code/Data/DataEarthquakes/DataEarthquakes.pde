/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 * </ul> * <p>Updated: 2012-08-14 Daniel Sauter/j.duran</p>
 */

import ketai.sensors.*;

Table earthquakes, delta;

int count;
PImage world;
String src = "http://earthquake.usgs.gov/earthquakes/catalogs/eqs1hour-M0.txt";  //(1)

void setup()
{
  location = new KetaiLocation(this);
  try {
    earthquakes = loadTable(src);  //(2)
  }
  catch
    (Exception x) {
    println("Failed to open online stream reverting to local data");
    earthquakes = loadTable("eqs1hour_2012-07-24.txt");  //(3)
  }
  count = earthquakes.getRowCount();

  orientation(LANDSCAPE);
  world = loadImage("world.png");
}

void draw ()
{
  background(127);
  image(world, 0, 0, width, height);  //(4)

  for (int row = 1; row < count; row++)
  {
    float lon = earthquakes.getFloat(row, 5);  //(5)
    float lat = earthquakes.getFloat(row, 4);  //(6)
    float magnitude = earthquakes.getFloat(row, 6);    //(7)
    float x = map(lon, -180, 180, 0, width);    //(8)
    float y = map(lat, 85, -60, 0, height);    //(9)
    noStroke();
    fill(0);
    ellipse(x, y, 5, 5);
    float dimension = map(magnitude, 0, 10, 0, 100);  //(10)
    float freq = map(millis()%(1000/magnitude), 
      0, 1000/magnitude, 0, magnitude*50);    //(11)
    fill(255, 127, 127, freq);  //(12)
    ellipse(x, y, dimension, dimension);

    Location quake;
    quake = new Location("quake");  //(13)
    quake.setLongitude(lon); 
    quake.setLatitude(lat);
    int distance = int(location.getLocation().distanceTo(quake)/1609.34);    //(14)
    noFill();
    stroke(150);
    ellipse(myX, myY, dist(x, y, myX, myY)*2, dist(x, y, myX, myY)*2);    //(15)
    fill(0);
    text(distance, x, y);    //(16)
  }

  // Current Device location
  noStroke();
  float s = map(millis() % (100*accuracy/3.28), 0, 100*accuracy/3.28, 0, 127);    //(17)
  fill(127, 255, 127);
  ellipse(myX, myY, 5, 5);
  fill(127, 255, 127, 127-s);
  ellipse(myX, myY, s, s);
}

