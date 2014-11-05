void setup() {
  size(displayWidth, displayHeight, P3D);   //(1)
  orientation(LANDSCAPE);
  noStroke();
}
void draw() 
{
  background(0);
  float lightX = map(mouseX, 0, width, 1, -1);  //(2)
  float lightY = map(mouseY, 0, height, 1, -1);  //(3)

  lights();  //(4)
  directionalLight(200, 255, 200, lightX, lightY, -1);  //(5)

  translate(width/4, height/2, 0); 
  box(height/3); 
  translate(width/2, 0, 0);
  sphere(height/4);
}

