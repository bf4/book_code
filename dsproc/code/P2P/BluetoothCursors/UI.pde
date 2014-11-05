// UI methods

void mousePressed()
{
  if (mouseY <= 50 && mouseX > 0 && mouseX < width/3)
    KetaiKeyboard.toggle(this);  //(1)
  else if (mouseY <= 50 && mouseX > width/3 && mouseX < 2*(width/3)) //config button
    isConfiguring=true; //(2)
  else if (mouseY <= 50 && mouseX >  2*(width/3) && mouseX < width) // draw button
  {
    if (isConfiguring)
    {
      background(78, 93, 75);
      isConfiguring=false;
    }
  }
}

void keyPressed() {
  if (key =='c')
  {
    //If we have not discovered any devices, try prior paired devices
    if (bt.getDiscoveredDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getDiscoveredDeviceNames());  //(3)
    else if (bt.getPairedDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getPairedDeviceNames());  //(4)
  }
  else if (key == 'd')
    bt.discoverDevices();  //(5)
  else if (key == 'b')
    bt.makeDiscoverable();  //(6)
}

void drawUI()
{
  pushStyle();  //(7)
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
  text("Keyboard", 5, 30); //(8)
  text("Bluetooth", width/3+5, 30); //(9)
  text("Interact", width/3*2+5, 30); //(10)
  popStyle();
}

void onKetaiListSelection(KetaiList connectionList)  //(11)
{
  String selection = connectionList.getSelection();  //(12)
  bt.connectToDeviceByName(selection);  //(13)
  connectionList = null;  //(14)
}

