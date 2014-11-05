// UI methods
void mousePressed() {
  //keyboard button -- toggle virtual keyboard
  if (mouseY <= 50 && mouseX > 0 && mouseX < width/3)
    KetaiKeyboard.toggle(this);
  else if (mouseY <= 50 && mouseX > width/3 && mouseX < 2*(width/3)) //config button
  { 
    isConfiguring=true;
  }
  else if (mouseY <= 50 && mouseX >  2*(width/3) && mouseX < width) { // draw button
    if (isConfiguring) {
      isConfiguring=false;
    }
  }
}
void keyPressed() {
  if (key == 'c') {
    if (devices.size() > 0)
      connectionList = new KetaiList(this, devices);
  }
  else if (key == 'd') {
    direct.discover();  //(1)
    println("device list contains "  + devices.size() + " elements");
  }
  else if (key == 'i')
    direct.getConnectionInfo();  //(2)
  else if (key == 'o') {
    if (direct.getIPAddress().length() > 0)
      oscP5 = new OscP5(this, 12000);  //(3)
  }
}

void drawUI()
{
  pushStyle();
  fill(0);
  stroke(255);
  rect(0, 0, width/3, 50);

  if (isConfiguring)
  {
    noStroke();
    fill(78, 93, 75);
  }
  else
    fill(0);

  rect(width/3, 0, width/3, 50);

  if (!isConfiguring)
  {  
    noStroke();
    fill(78, 93, 75);
  }
  else
  {
    fill(0);
    stroke(255);
  }
  rect((width/3)*2, 0, width/3, 50);

  fill(255);
  text("Keyboard", 5, 30); 
  text("WiFi Direct", width/3+5, 30); 
  text("Interact", width/3*2+5, 30); 

  popStyle();
}

void onKetaiListSelection(KetaiList klist)
{
  String selection = klist.getSelection();
  direct.connect(selection);  //(4)
  connectionList = null;
}

