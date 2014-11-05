/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Location Features:
 * <ul>
 * <li>Uses GPS location data (latitude, longitude, altitude (if available)</li>
 * <li>Updates if location changes by 1 meter, or every 10 seconds</li>
 * <li>If unavailable, defaults to system provider (cell tower or WiFi network location)</li>
 * </ul>
 * <p>Syntax:
 * <ul>
 * <li>onLocationEvent(double latitude, double longitude, double altitude, float accuracy)</li>
 * <li>onLocationEvent(double latitude, double longitude, double altitude)</li>
 * <li>onLocationEvent(double latitude, double longitude)</li>
 * <li>onLocationEvent(Location location)</li>
 * </p>
 * <p>Updated: 2012-01-19 Daniel Sauter/j.duran</p>
 */

import ketai.sensors.*; 
KetaiLocation location;  //(1)
double longitude, latitude, altitude;
float accuracy;

void setup() {
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(36);
  location = new KetaiLocation(this);  //(2)
}

void draw() {
  background(78, 93, 75);
  if (location.getProvider() == "none")  //(3)
    text("Location data is unavailable. \n" +
      "Please check your location settings.", width/2, height/2);
  else
    text("Latitude: " + latitude + "\n" +  //(4)
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" + 
      "Accuracy: " + accuracy + "\n" + 
      "Provider: " + location.getProvider(), width/2, height/2);  
}

void onLocationEvent(double _latitude, double _longitude, 
  double _altitude, float _accuracy) {  //(5)  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  accuracy = _accuracy;
  println("lat/lon/alt/acc: " + latitude + "/" + longitude + "/" 
    + altitude + "/" + accuracy);
}
