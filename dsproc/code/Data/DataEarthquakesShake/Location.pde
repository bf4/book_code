// Location Code

KetaiLocation location;  //(1)

float accuracy;
float myX, myY;

void onLocationEvent(double lat, double lon, double alt, float acc)
{
  myX = map((float)lon, -180, 180, 0, width);
  myY = map((float)lat, 85, -60, 0, height);
  accuracy = acc;
  println("Current Longitude: " + lon + " Longitude: " + lat);
}

