/**
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */

import android.os.Environment;

Table tsv;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup()
{
  orientation(LANDSCAPE);
  noStroke();
  textSize(24);
  textAlign(CENTER);

  try {
    tsv = new Table(new File(
    Environment.getExternalStorageDirectory().getAbsolutePath() +  
      "/data.tsv"));
  } 
  catch (Exception e) {
    tsv = new Table();
  }
  for (int row = 1; row < tsv.getRowCount(); row++)
  {
    points.add(new PVector(tsv.getInt(row, 0), tsv.getInt(row, 1), 0));
  }
}

void draw()
{
  background(78, 93, 75);
  for (int i = 0; i < points.size(); i++)
  {
    PVector p = points.get(i);
    ellipse(p.x, p.y, 5, 5);
  } 
  text("Number of points: " + points.size(), width/2, 50);
}

void keyPressed()
{
  try {
    tsv.save(new File(
    Environment.getExternalStorageDirectory().getAbsolutePath() + //(1)
    "/data.tsv"), "tsv");
  }
  catch (IOException iox) {
    println("Failed to write file." + iox.getMessage());
  }
}

void mouseDragged()
{
  points.add(new PVector(mouseX, mouseY, 0));
  String[] data = { 
    Integer.toString(mouseX), Integer.toString(mouseY)
    };
    tsv.addRow();
  tsv.setRow(tsv.getRowCount()-1, data);
}

