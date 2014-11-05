/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>KetaiSQLite Features:
 * <ul>
 * <li>Captures Sensor data into SQLite database</li>
 * <li>Exports data into .csv flat file</li>
 * <li>Captures all sensors registered via SensorEvent into one db/file</li>
 * </ul>
 * <p>Updated: 2012-07-25 Daniel Sauter/j.duran</p>
 */

import ketai.data.*;
import ketai.sensors.*;

KetaiSensor sensor;
KetaiSQLite db;
boolean isCapturing = false;
float G = 9.80665;
String CREATE_DB_SQL = 
  "CREATE TABLE data ( time INTEGER PRIMARY KEY, x FLOAT, y FLOAT, z FLOAT);";  //(1)

void setup() {
  db = new KetaiSQLite(this);
  sensor = new KetaiSensor(this);
  orientation(LANDSCAPE);
  textAlign(LEFT);
  textSize(24);
  rectMode(CENTER);
  frameRate(5);
  if ( db.connect() ) { //(2) 
    if (!db.tableExists("data"))  //(3)
      db.execute(CREATE_DB_SQL);  //(4)
  }
  sensor.start();
}

void draw() {
  background(78, 93, 75);
  if (isCapturing)
    text("Recording data...\n(tap screen to stop)" +"\n\n" +
      "Current Data count: " + db.getDataCount(), width/2, height/2);  //(5)
  else
    plotData();  //(6)
}

void keyPressed() {
    if (keyCode == BACK) {  //(7)
      db.execute( "DELETE FROM data" );  
    } 
    else if (keyCode == MENU) {  //(8)
      if (isCapturing)
        isCapturing = false;
      else
        isCapturing = true;
    }
}

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy) {
  if (db.connect() && isCapturing) {
    if (!db.execute(
      "INSERT into data (`time`,`x`,`y`,`z`) VALUES ('" +  //(9)
      System.currentTimeMillis() + "', '" + x + "', '" + y + "', '" + z + "')"
      )
    )  
      println("Failed to record data!" );  //(10)
  }
}
void plotData() {
  if (db.connect()) {
    pushStyle();
    line(0, height/2, width, height/2);
    line(mouseX, 0, mouseX, height);
    noStroke();
    db.query("SELECT * FROM data ORDER BY time DESC");  //(11)
    int  i = 0;    
    while (db.next ())  //(12)
    {
      float x = db.getFloat("x");  //(13)
      float y = db.getFloat("y");
      float z = db.getFloat("z");
      float plotX, plotY = 0;

      fill(255, 0, 0);
      plotX = map(i, 0, db.getDataCount(), 0, width);
      plotY = map(x, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 3, 3);  //(14)
      if (abs(mouseX-plotX) < 1)
        text(nfp(x, 2, 2), plotX, plotY);  //(15)

      fill(0, 255, 0);
      plotY = map(y, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 3, 3); //(16)
      if (abs(mouseX-plotX) < 1)
        text(nfp(y, 2, 2), plotX, plotY);

      fill(0, 0, 255);
      plotY = map(z, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 3, 3); //(17)
      if (abs(mouseX-plotX) < 1)
      {
        text(nfp(z, 2, 2), plotX, plotY);
        fill(0);
        text("#" + i, mouseX, height);
      }
      i++;
    }
    popStyle();
  }
}

