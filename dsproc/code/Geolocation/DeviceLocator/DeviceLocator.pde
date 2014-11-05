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
 * <p>Updated: 2012-01-20 Daniel Sauter/j.duran</p>
 */

import ketai.sensors.*; 
double longitude, latitude, altitude, accuracy;
KetaiLocation location;  //(1)
Location otherDevice;  //(2)
KetaiSensor sensor;
String serverMessage="";
String myName, deviceTracked;
String serverURL = "http://www.ketaiProject.com/rad/location.php"; //(3)
float compass;

void setup() {
  otherDevice = new Location("yourNexus");
  sensor = new KetaiSensor(this);
  sensor.start();
  location = new KetaiLocation(this);
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(28);
  myName = "yourNexus";  //(4)
  deviceTracked = "myNexus";  //(5)
}

void draw() {
  background(78, 93, 75);
  float bearing = location.getLocation().bearingTo(otherDevice);
  float distance = location.getLocation().distanceTo(otherDevice);
  if (mousePressed) {
    if (location.getProvider() == "none")
      text("Location data is unavailable. \n" +
        "Please check your location settings.", 0, 0, width, height);
    else
      text("Location data:\n" + 
        "Latitude: " + latitude + "\n" + 
        "Longitude: " + longitude + "\n" + 
        "Altitude: " + altitude + "\n" +
        "Accuracy: " + accuracy + "\n" +
        "Distance to Other Device: "+ nf(distance, 0, 2) + " m\n" + 
        "Provider: " + location.getProvider()+ "\n" + 
        "Last Server Message: " + serverMessage, 20, 0, width, height );
  }
  else {
    translate(width/2, height/2);
    rotate(radians(bearing) - radians(compass));
    stroke(255);
    triangle(-width/4, 0, width/4, 0, 0, -width/2);
    text((int)distance + " m", 0, 50);
    text(nf(distance*0.000621, 0, 2) + " miles", 0, 100);
  }
}
void onLocationEvent(Location _location)  //(6)
{
  // Print out the location object
  println("onLocation event: " + _location.toString());
  longitude = _location.getLongitude();
  latitude = _location.getLatitude();
  altitude = _location.getAltitude();
  accuracy = _location.getAccuracy();
  updateMyLocation();
}
void updateMyLocation()
{
  if (myName != "")
  {
    String url = serverURL+"?update="+myName+
      "&location="+latitude+","+longitude+","+altitude;  //(7)
    String result[] = loadStrings(url);  //(8)
    if (result.length > 0)
      serverMessage = result[0];
  }
}

void mousePressed()
{
  if (deviceTracked != "")
  {
    String url = serverURL + "?get="+deviceTracked;  //(9)
    String result[] = loadStrings(url);
    for (int i=0; i < result.length; i++)
      println(result[i]);
    serverMessage = result[0];
    // Let's update our target device location
    String[] parameters = split(result[0], ",");
    if (parameters.length == 3)  //(10)
    {
      otherDevice = new Location(deviceTracked);
      otherDevice.setLatitude(Double.parseDouble(parameters[0]));
      otherDevice.setLongitude(Double.parseDouble(parameters[1]));
      otherDevice.setAltitude(Double.parseDouble(parameters[2]));
    }
  }
  updateMyLocation(); //(11)
}
void onOrientationEvent(float x, float y, float z, long time, int accuracy)
{ 
  compass = x;  
  // Angle between magnetic north and device y-axis, around z-axis.
  // Range: 0 to 359 degrees
  // 0=North, 90=East, 180=South, 270=West
}

