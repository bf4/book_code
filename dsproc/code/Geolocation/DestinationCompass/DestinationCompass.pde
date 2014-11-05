/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>KetaiLocation Features:
 * <ul>
 * <li>Uses GPS location data (latitude, longitude, altitude (if available)</li>
 * <li>Updates if location changes by 1 meter, or every 10 seconds</li>
 * <li>If unavailable, defaults to system provider (cell tower or WiFi network location)</li>
 * </ul>
 * More information:
 * http://developer.android.com/reference/android/location/Location.html</p>
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */

import ketai.sensors.*;
import android.location.Location;

KetaiLocation location;
KetaiSensor sensor;
Location destination;
PVector locationVector = new PVector();
float compass;  //(1)

void setup() {
  destination = new Location("uic"); 
  destination.setLatitude(41.824698);
  destination.setLongitude(-87.658777);
  location = new KetaiLocation(this);
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(28);
  smooth();
}

void draw() {
  background(78, 93, 75);
  float bearing = location.getLocation().bearingTo(destination);  //(2)
  float distance = location.getLocation().distanceTo(destination);
  if (mousePressed) {
    if (location.getProvider() == "none")
      text("Location data is unavailable. \n" +
        "Please check your location settings.", 0, 0, width, height);
    else
      text("Location:\n" + 
        "Latitude: " + locationVector.x + "\n" + 
        "Longitude: " + locationVector.y + "\n" + 
        "Compass: "+ round(compass) + " deg.\n" +
        "Destination:\n" + 
        "Bearing: " + bearing + "\n" + 
        "Distance: "+ distance + " m\n" + 
        "Provider: " + location.getProvider(), 20, 0, width, height);
  } 
  else {
    translate(width/2, height/2);  //(3)
    rotate(radians(bearing) - radians(compass));  //(4)
    stroke(255);
    triangle(-width/4, 0, width/4, 0, 0, -width/2);  //(5)
    text((int)distance + " m", 0, 50);
    text(nf(distance*0.000621, 0, 2) + " miles", 0, 100);  //(6)
  }
}

void onLocationEvent(Location _location) {
  println("onLocation event: " + _location.toString());
  locationVector.x = (float)_location.getLatitude();  //(7)
  locationVector.y = (float)_location.getLongitude();
}
void onOrientationEvent(float x, float y, float z, long time, int accuracy) { //(8)
  compass = x;  
  // Azimuth angle between magnetic north and device y-axis, around z-axis.
  // Range: 0 to 359 degrees
  // 0=North, 90=East, 180=South, 270=West 
}
