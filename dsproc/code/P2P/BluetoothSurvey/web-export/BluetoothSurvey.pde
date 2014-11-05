/**
 * <p>Ketai Library for Android: http://KetaiProject.org</p>
 *
 * <p>KetaiBluetooth wraps the Android Bluetooth RFCOMM Features:
 * <ul>
 * <li>Enables Bluetooth for sketch through android</li>
 * <li>Provides list of available Devices</li>
 * <li>Enables Discovery</li>
 * <li>Allows writing data to device</li>
 * </ul>
 * <p>Updated: 2012-05-18 Daniel Sauter/j.duran</p>
 */
// Required Bluetooth methods on startup
import android.os.Bundle;
import android.content.Intent;

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import oscP5.*;

KetaiBluetooth bt;

KetaiList connectionList;
String info = "";
boolean isConfiguring = true;
String UIText;
color clientColor = color(112, 138, 144);
color serverColor = color(127);

boolean isServer = true;

ArrayList<Question> questions = new ArrayList<Question>();  //(1)
ArrayList<String> devicesDiscovered = new ArrayList();
Question currentQuestion;  //(2)
int currentStatID = 0;
Button previous, next;

void setup()
{   
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textSize(24);
  rectMode(CORNER);
  previous = new Button("previous.png", 30, height/2);
  next = new Button("next.png", width-30, height/2);

  bt.start();
  if (isServer)
    loadQuestions(); 

  UIText =  "[m] - make this device discoverable\n" +
    "[d] - discover devices\n" +
    "[c] - connect to device from list\n" +
    "[p] - list paired devices\n" +
    "[i] - show Bluetooth info";

  KetaiKeyboard.show(this);
}

void draw()
{
  if (isConfiguring)
  {
    ArrayList<String> devices;

    if (isServer)
      background(serverColor);  //green for server
    else
      background(clientColor); //grey for clients

    if (key == 'i')
      info = getBluetoothInformation();
    else
    {
      if (key == 'p')
      {
        info = "Paired Devices:\n";
        devices = bt.getPairedDeviceNames();
      }
      else
      {
        info = "Discovered Devices:\n";
        devices = bt.getDiscoveredDeviceNames();
      }

      for (int i=0; i < devices.size(); i++)
      {
        info += "["+i+"] "+devices.get(i).toString() + "\n";
      }
    }
    text(UIText + "\n\n" + info, 5, 90);
  }
  else
  {
    if (questions.size() < 1)
      requestQuestions();

    if (questions.size() > 0 && currentQuestion == null)
      currentQuestion = questions.get(0);  //(3)

    if (isServer)
      background(serverColor);
    else
      background(clientColor);
    pushStyle();
    fill(255);
    stroke(255);
    ellipse(mouseX, mouseY, 20, 20);
    if (currentQuestion != null)
      currentQuestion.display(25, 100);
    //      text(currentQuestion.toString(), 75, 75);  //(4)
    popStyle();
  }
  drawUI();
  broadcastStats();
}

void onBluetoothDataEvent(String who, byte[] data)
{
  //   but allows construction by byte array
  KetaiOSCMessage m = new KetaiOSCMessage(data);
  if (m.isValid())
  {
    print(" addrpattern: "+m.addrPattern());

    //handle request for questions
    if (m.checkAddrPattern("/poll-request/"))  //(5)
    {
      if (isServer)
      {
        int lastID =  m.get(0).intValue();

        for (int j = 0; j < questions.size(); j++)
        {
          Question q = questions.get(j);

          if (q.id <= lastID)
            continue;

          OscMessage msg = new OscMessage("/poll-question/");  //(6)
          msg.add(q.id);
          msg.add(q.question);
          msg.add(q.answer1);
          msg.add(q.answer2);
          msg.add(q.answer3);
          bt.broadcast(msg.getBytes());
        }
      }
    }
    else if (m.checkAddrPattern("/poll-question/"))  //(7)
    {
      if (isServer)
        return;

      //id, question, choice a, choice b, choice c
      if (m.checkTypetag("issss"))  //(8)
      {
        int _id = m.get(0).intValue();
        println("processing question id: " + _id);

        //we already have this question...skip
        if (findQuestion(_id) != null)
          return;

        Question q = new Question(  //(9)
        m.get(0).intValue(), 
        m.get(1).stringValue(), 
        m.get(2).stringValue(), 
        m.get(3).stringValue(), 
        m.get(4).stringValue());
        questions.add(q);
      }
    }
    else if (m.checkAddrPattern("/poll-answer/"))  //(10)
    {
      if (!isServer)
        return;
      //question id + answer
      if (m.checkTypetag("ii"))  //(11)
      {
        Question _q = findQuestion(m.get(0).intValue());
        if (_q != null)
        {
          println("got answer from " + who + " for question " + 
            m.get(0).intValue() + ", answer: " + m.get(1).intValue());
          _q.processAnswerStat(m.get(1).intValue()); //(12)
          OscMessage msg = new OscMessage("/poll-update/");
          println("sending poll update for question " + _q.id + "-" + 
            _q.total1 + "," + _q.total2 + "," + _q.total3);
          msg.add(_q.id);
          msg.add(_q.total1);
          msg.add(_q.total2);
          msg.add(_q.total3);
          bt.broadcast(msg.getBytes());
        }
      }
    }
    //update answer stats
    else if (m.checkAddrPattern("/poll-update/") && !isServer)  //(13)
    {
      //question id + 3 totals
      if (m.checkTypetag("iiii"))  //(14)
      {
        int _id = m.get(0).intValue();
        Question _q = findQuestion(_id);
        if (_q != null)
        {
          println("got poll update for question " + 
            _id + " vals " + m.get(1).intValue() + ", " + 
            m.get(2).intValue() + "," + m.get(3).intValue());

          _q.updateStats(m.get(1).intValue(), //(15)
          m.get(2).intValue(), 
          m.get(3).intValue());
        }
      }
    }
    else if (m.checkAddrPattern("/poll-current-question/") && !isServer)
    {
      int targetQuestionId =  m.get(0).intValue(); 
      Question q = findQuestion(targetQuestionId);
      if (q != null)
        currentQuestion = q;
    }
  }
}

String getBluetoothInformation()
{
  String btInfo = "BT Server Running: ";
  btInfo += bt.isStarted() + "\n";
  btInfo += "Device Discoverable: "+bt.isDiscoverable() + "\n";
  btInfo += "Is Poll Server: " + isServer + "\n";
  btInfo += "Question(s) Loaded: " + questions.size(); 
  btInfo += "\nConnected Devices: \n";

  ArrayList<String> devices = bt.getConnectedDeviceNames();
  for (String device: devices)
  {
    btInfo+= device+"\n";
  }
  return btInfo;
}

void loadQuestions()
{
  String[] lines;
  lines = loadStrings("questions.txt");    //(16)

  if (lines != null)
  {
    for (int i = 0; i < lines.length; i++)
    {
      Question q = new Question(lines[i]);
      if (q.question.length() > 0)
      {
        q.id = i+1;
        questions.add(q);  //(17)
      }
    }
  }
}

void requestQuestions()
{
  //throttle request
  if (frameCount%30 == 0)
  {
    int lastID = 0;

    if (questions.size() > 0)
    {
      Question _q = questions.get(questions.size()-1);
      lastID = _q.id;
    }

    OscMessage m = new OscMessage("/poll-request/");  //(18)
    m.add(lastID);
    bt.broadcast(m.getBytes());
  }
}

Question findQuestion(int _id)  //(19)
{
  for (int i=0; i < questions.size(); i++)
  {
    Question q = questions.get(i);
    if (q.id == _id)
      return q;
  } 
  return null;
}

void broadcastStats()
{
  if (!isServer)
    return;

  if (frameCount%60 == 0)
  {  
    if ( currentStatID > 0 && currentStatID <= questions.size())
    {
      Question _q = findQuestion(currentStatID);
      if (_q != null)
      { 
        println("sending poll update for question " + _q.id + "-" + 
          _q.total1 + "," + _q.total2 + "," + _q.total3);
        OscMessage msg = new OscMessage("/poll-update/");  //(20)
        msg.add(_q.id);
        msg.add(_q.total1);
        msg.add(_q.total2);
        msg.add(_q.total3);
        bt.broadcast(msg.getBytes());
        currentStatID++;
      }
    }
    else {
      if (questions.size() > 0)
        currentStatID = questions.get(0).id;
    }
    sendCurrentQuestionID();
  }
}
void sendCurrentQuestionID() {
  if (currentQuestion == null)
    return;
  OscMessage msg = new OscMessage("/poll-current-question/");
  msg.add(currentQuestion.id);
  bt.broadcast(msg.getBytes());
}


void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this); 
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}
// Question Class

class Question  //(21)
{
  int id=0;
  String question="";
  String answer1, answer2, answer3="";
  int total1, total2, total3 = 0;
  int myAnswer, correctAnswer;

  Question(String _row)  //(22)
  {
    String[] parts = split(_row, '\t');    //(23)
    if (parts.length == 4)
    {
      question = parts[0];
      answer1 = parts[1];
      answer2 = parts[2];
      answer3 = parts[3];
    }
  }

  Question(int _id, String q, String a1, String a2, String a3)  //(24)
  {
    id = _id;
    question = q;
    answer1 = a1;
    answer2 = a2;
    answer3 = a3;
  } 

  void updateStats(int s1, int s2, int s3)  //(25)
  {
    total1 = s1;
    total2 = s2;
    total3 = s3;
  }
  void processAnswerStat(int _answer)  //(26)
  {
    if (_answer == 1)  
      total1++;
    else if (_answer == 2)
      total2++;
    else if (_answer == 3)
      total3++;
  }

  void setAnswer(int _answer)
  {
    myAnswer = _answer;
    processAnswerStat(_answer);
  }

  float getAnswerStat(int _answer)  //(27)
  {
    if (_answer == 1)  
      return total1;
    else if (_answer == 2)
      return total2;
    else if (_answer == 3)
      return total3;
    return 0;
  }

  void saveResults()  //(28)
  {
    String line = question + "\t" + 
      answer1 + "\t" + total1 + "\t";
    line += answer2 + "\t" + total2 + "\t" + 
      answer3 + "\t" + total3;
  }

  boolean isAnswered()
  {
    if (myAnswer == 0)
      return false;
    return true;
  }

  void display(int x, int y) //(29)
  { 
    pushStyle();
    pushMatrix();
    translate(x, y);
    if (myAnswer == 0  && !isServer)
    {
      text(id+") " + question + "\n\n" + 
        "[1] " + answer1 + "\n" +
        "[2] " + answer2 + "\n" + 
        "[3] " + answer3, 0, 0);
    }
    else
    {

      float total = total1+total2+total3;

      //avoid div by 0
      if (total == 0)
        total = 1;

      float lineheight = textAscent()+textDescent();
      lineheight = 20;
      text( id+") " + question, 0, 0);

      textAlign(LEFT, TOP);
      translate(0, lineheight*2);

      text(answer1 + " (" + nf((total1/total)*100, 2, 2) + " %) ", 0, 0);
      translate(0, lineheight*1.5);
      rect(0, 0, map((total1/total)*100, 0, 100, 0, width-150), lineheight-5);
      translate(0, lineheight*1.5);

      text(answer2 + " (" +nf( (total2/total)*100, 2, 2 ) + " %) ", 0, 0);
      translate(0, lineheight*1.5);
      rect(0, 0, map((total2/total)*100, 0, 100, 0, width-150), lineheight-5);
      translate(0, lineheight*1.5);


      text(answer3 + " (" +nf( (total3/total)*100, 2, 2) + " %) ", 0, 0);
      translate(0, lineheight*1.5);
      rect(0, 0, map((total3/total)*100, 0, 100, 0, width-150), lineheight-5);
      translate(0, lineheight*2.5);

      if (isServer)
        text("Number of Answers for this question: " + total, 0, 0);
    }
    popMatrix();
    popStyle();
  }
}

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
        currentQuestion = findQuestion(currentQuestion.id-1); //(30)
      sendCurrentQuestionID();
    }
    else if (next.isPressed()  && isServer) //next question
    {
      if (findQuestion(currentQuestion.id+1) != null)
        currentQuestion = findQuestion(currentQuestion.id+1); //(31)
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
        m.add(1);  //(32)
        bt.broadcast(m.getBytes());
      }
      else if (key == '2') {
        currentQuestion.setAnswer(2);
        OscMessage m = new OscMessage("/poll-answer/");
        m.add(currentQuestion.id);
        m.add(2);  //(33)
        bt.broadcast(m.getBytes());
      }
      else if (key == '3') {
        currentQuestion.setAnswer(3);
        OscMessage m = new OscMessage("/poll-answer/");
        m.add(currentQuestion.id);
        m.add(3);  //(34)
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


