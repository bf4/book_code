/** 
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */
 
Table tsv;  //(1)
ArrayList<PVector> points = new ArrayList<PVector>();  //(2)
void setup()
{
  orientation(LANDSCAPE);
  noStroke();
  textSize(24);
  textAlign(CENTER);
  try {  //(3)
    tsv = new Table(new File(sketchPath("")+"data.tsv"));  //(4)
  } 
  catch (Exception e) {  //(5)
    tsv = new Table();  //(6)
  }
  for (int row = 1; row < tsv.getRowCount(); row++)
  {
    points.add(new PVector(tsv.getInt(row, 0), tsv.getInt(row, 1), 0));  //(7)
  }
}

void draw()
{
  background(78, 93, 75);
  for (int i = 0; i < points.size(); i++)
  {
    ellipse(points.get(i).x, points.get(i).y, 5, 5);   //(8)
  } 
  text("Number of points: " + points.size(), width/2, 50);
}

void mouseDragged()
{
  points.add(new PVector(mouseX, mouseY));  //(9)
  String[] data = { 
    Integer.toString(mouseX), Integer.toString(mouseY)  //(10)
  };
  tsv.addRow();  //(11)
  tsv.setRow(tsv.getRowCount()-1, data);  //(12)
}

void keyPressed()
{
  try {
    tsv.save(new File(sketchPath("")+"data.tsv"), "tsv");  //(13)
  }
  catch(IOException iox) {
    println("Failed to write file." + iox.getMessage());
  }
}

