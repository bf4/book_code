/**
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */

Table colors;

void setup(){
  colors = loadTable("colors.csv");  //(1)
  
  textSize(24);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  noStroke();
  noLoop();
  int count = colors.getRowCount();
 
  for (int row = 0; row < count; row++) {
    color c =  unhex("FF"+colors.getString(row, 1).substring(1));  //(2)
    float swatchHeight = height/count;
    fill(c);  //(3)
    rect(width/2, swatchHeight/2, width, swatchHeight);
    fill(255);
    text(colors.getString(row, 0), width/2, swatchHeight/2);
    translate(0, swatchHeight);
  }
}

