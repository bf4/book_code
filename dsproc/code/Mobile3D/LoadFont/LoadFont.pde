PFont font;
float scaleFactor = 1;

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  orientation(LANDSCAPE);
  noStroke();
  
  font = loadFont("DroidSerif-48.vlw"); //(1)
  textFont(font);
  textAlign(CENTER, CENTER);
}

void draw() 
{
  background(0); 

  pointLight(0, 150, 250, 0, height/2, 200);
  pointLight(250, 50, 0, width, height/2, 200);
  
  for (int y = 0; y < height; y+=50) {
    for (int x = 0; x < width; x+=100) { 
      float distance = dist(x, y, mouseX, mouseY);
      float z = map(distance, 0, width, 0, -500);
      textSize(scaleFactor);  //(2)
      text("["+ x +","+ y +"]", x, y, z);
    }
  }
}

void mouseDragged()
{
  scaleFactor = map(mouseY, 0, height, 0, 48);  //(3)
}
