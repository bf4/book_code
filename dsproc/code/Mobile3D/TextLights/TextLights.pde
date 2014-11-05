PFont font;  //(1)

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  orientation(LANDSCAPE);
  noStroke();
  
  font = createFont("SansSerif", 18);  //(2)
  textFont(font);  //(3)
  textAlign(CENTER, CENTER);
}

void draw() 
{
  background(0); 

  pointLight(0, 150, 250, 0, height/2, 200);  //(4)
  pointLight(250, 50, 0, width, height/2, 200);  //(5)

  for (int y = 0; y < height; y+=30) {  //(6)
    for (int x = 0; x < width; x+=60) {  //(7)
      float distance = dist(x, y, mouseX, mouseY);  //(8)
      float z = map(distance, 0, width, 0, -500);  //(9)
      text("["+ x +","+ y +"]", x, y, z);  //(10)
    }

  }

  if (frameCount%10 == 0) 
    println(frameRate);
}
