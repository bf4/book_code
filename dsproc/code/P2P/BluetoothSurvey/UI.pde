// UI methods
void mousePressed() {
  if (mouseY <= 50 && mouseX > 0 && mouseX < width/3)
    KetaiKeyboard.toggle(this); 
  else if (mouseY <= 50 && mouseX > width/3 && mouseX < 2*(width/3))
    isConfiguring=true;
  else if (mouseY <= 50 && mouseX >  2*(width/3) && mouseX < width && 
    bt.getConnectedDeviceNames().size() > 0)
  {
    if (isConfiguring) {
      background(127);
      isConfiguring=false;
    }
  }

  if (bt.getConnectedDeviceNames().size() > 0)  {
    if (currentQuestion == null)
      return;
    if (previous.isPressed() && isServer) //previous question
    {
      if (findQuestion(currentQuestion.id-1) != null)
        currentQuestion = findQuestion(currentQuestion.id-1); //(1)
      sendCurrentQuestionID();
    }
    else if (next.isPressed()  && isServer) //next question
    {
      if (findQuestion(currentQuestion.id+1) != null)
        currentQuestion = findQuestion(currentQuestion.id+1); //(2)
      else
        requestQuestions();
      sendCurrentQuestionID();
    }
  }
}

void keyPressed() {
  if (!isConfiguring && !isServer) {
    if (currentQuestion != null && !currentQuestion.isAnswered())
      if (key == '1') {
        currentQuestion.setAnswer(1);
        OscMessage m = new OscMessage("/poll-answer/");
        m.add(currentQuestion.id);
        m.add(1);  //(3)
        bt.broadcast(m.getBytes());
      }
      else if (key == '2') {
        currentQuestion.setAnswer(2);
        OscMessage m = new OscMessage("/poll-answer/");
        m.add(currentQuestion.id);
        m.add(2);  //(4)
        bt.broadcast(m.getBytes());
      }
      else if (key == '3') {
        currentQuestion.setAnswer(3);
        OscMessage m = new OscMessage("/poll-answer/");
        m.add(currentQuestion.id);
        m.add(3);  //(5)
        bt.broadcast(m.getBytes());
      }
  }
  else if (key =='c') {
    if (bt.getDiscoveredDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getDiscoveredDeviceNames());
    else if (bt.getPairedDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getPairedDeviceNames());
  }
  else if (key == 'd')
    bt.discoverDevices();
  else if (key == 'm')
    bt.makeDiscoverable();
}

void drawUI() {
  pushStyle();
  fill(0);
  stroke(255);
  rect(0, 0, width/3, 50);

  if (isConfiguring)
  {
    noStroke();
    fill(127);
  }
  else if (bt.getConnectedDeviceNames().size() > 0 && isServer)
  {    
    previous.draw();
    next.draw();
  }
  rect(width/3, 0, width/3, 50);

  if (!isConfiguring)
  {  
    noStroke();
    if (isServer)
      fill(serverColor);
    else
      fill(clientColor);
  }
  else
  {
    fill(0);
    stroke(255);
  }
  rect((width/3)*2, 0, width/3, 50);

  fill(255);
  text("Keyboard", 5, 32); 
  text("Bluetooth", width/3+5, 32);

  if (bt.getConnectedDeviceNames().size() > 0) 
    if (isServer)
      text("Survey Server", width/3*2+5, 32); 
    else
      text("Survey Client", width/3*2+5, 32); 

  popStyle();
}

void onKetaiListSelection(KetaiList connectionList)
{
  String selection = connectionList.getSelection();
  bt.connectToDeviceByName(selection);
  connectionList = null;
  isServer = false;
}

class Button
{
  PImage icon;
  PVector location;
  int Size = 50;

  public Button(String imagefile, int x, int y)
  {
    icon = loadImage(imagefile);
    location = new PVector(x, y);
  }

  void draw()
  {
    pushStyle();
    imageMode(CENTER);
    if (icon != null)
      image(icon, location.x, location.y);
    else
      ellipse(location.x, location.y, Size, Size);
    popStyle();
  } 

  boolean isPressed()
  {
    return (dist(location.x, location.y, mouseX, mouseY) < Size/2);
  }
}

