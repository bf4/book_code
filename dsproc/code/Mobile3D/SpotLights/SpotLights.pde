PShape sphereShape;
int sSize;

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  orientation(LANDSCAPE);
  noStroke();
  fill(204);
  sphereDetail(60);    //(1)
  sSize = height/2;    //(2)
  sphereShape = createShape(SPHERE, sSize);
}

void draw() 
{
  background(0); 
  translate(width/2, height/2, 0); 

  spotLight(255, 0, 0, sSize/4, -sSize/4, 2*sSize, 0, 0, -1, radians(15), 0);  //(3)
  spotLight(0, 255, 0, -sSize/4, -sSize/4, 2*sSize, 0, 0, -1, radians(15), 0);  //(4)
  spotLight(0, 0, 255, 0, sSize/4, 2*sSize, 0, 0, -1, radians(15), 0);  //(5)

//  pointLight(255, 0, 0, sSize/4, -sSize/4, 2*sSize); 
//  pointLight(0, 255, 0, -sSize/4, -sSize/4, 2*sSize); 
//  pointLight(0, 0, 255, 0, sSize/4, 2*sSize); 
 
  shape(sphereShape);
}

