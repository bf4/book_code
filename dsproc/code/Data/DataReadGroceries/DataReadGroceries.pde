/** 
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */

Table groceries;

void setup()
{
  groceries = loadTable("groceries.tsv");  //(1)
  textSize(24);
  rectMode(CENTER);  //(2)
  textAlign(CENTER, CENTER);  //(3)
  noStroke();
  noLoop();  //(4)
  background(0);
  int count = groceries.getRowCount();  //(5)

  for (int row = 1; row < count; row++) {
    float rowHeight = height/count;  //(6)
    String amount = groceries.getString(row, 0);  //(7)
    String unit = groceries.getString(row, 1);  //(8)
    String item = groceries.getString(row, 2);  //(9)
    
    if (groceries.getString(row, 3).equals("store")) { //(10)
      fill(color(255, 110, 50));  //(11)
    } 
    else if (groceries.getString(row, 3).equals("market")) {
      fill(color(50, 220, 255));
    } 
    else {
      fill(127);
    }
    rect(width/2, rowHeight/2, width, rowHeight);  //(12)
    fill(255);
    text(amount + " " + unit + " " + item, width/2, rowHeight/2);  //(13)
    translate(0, rowHeight);//(14)
  }
}

