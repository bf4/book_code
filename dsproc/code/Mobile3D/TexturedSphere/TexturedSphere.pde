PShape sphereShape;  //(1)
PImage sphereTexture;  //(2)

void setup() {
  size(displayWidth,  displayHeight,  P3D);
  orientation(LANDSCAPE);
  noStroke();
  fill(255);
  
  sphereTexture = loadImage("earth_lights.jpg");  //(3)
  sphereShape = createShape(SPHERE, height/3);  //(4)
  sphereShape.texture(sphereTexture);   //(5)
}

void draw() {
  translate(width/2, height/2, 0);  
  rotateY(TWO_PI * frameCount / 600);  //(6)
  shape(sphereShape);
}
