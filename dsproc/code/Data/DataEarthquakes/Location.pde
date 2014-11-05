// Location Code

KetaiLocation location;  //(1)

float accuracy;
float myX, myY;  //(2)

void onLocationEvent(double lat, double lon, double alt, float acc)
{
  myX = map((float)lon, -180, 180, 0, width);  //(3)
  myY = map((float)lat, 85, -60, 0, height);  //(4)
  accuracy = acc;  //(5)
  println("Current Longitude: " + lon + " Longitude: " + lat);
}

