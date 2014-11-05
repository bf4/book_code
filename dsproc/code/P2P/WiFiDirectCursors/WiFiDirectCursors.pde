/**
 * <p>Ketai Library for Android: http://KetaiProject.org</p>
 *
 * <p>KetaiWiFiDirect Features:
 * <ul>
 * <li>Enables WiFi Direct networking using Processing for Android</li>
 * <li>Enables discovery of available WiFi Direct Devices</li>
 * <li>Allows writing data to WiFi Direct device</li>
 * </ul>
 * <p>Updated: 2012-05-31 Daniel Sauter/j.duran</p>
 */

import ketai.net.wifidirect.*;  //(1)
import ketai.net.*;
import ketai.ui.*;
import oscP5.*;
import netP5.*;

KetaiWiFiDirect direct;  //(2)
KetaiList connectionList;
String info = "";
PVector remoteCursor = new PVector();
boolean isConfiguring = true;
String UIText;

ArrayList<String> devices = new ArrayList();  //(3)
OscP5 oscP5;  //(4)
String clientIP = "";  //(5)

void setup()
{   
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textSize(24);

  direct = new KetaiWiFiDirect(this);  //(6)

  UIText =  "[d] - discover devices\n" +
    "[c] - pick device to connect to\n" +
    "[p] - list connected devices\n" + 
    "[i] - show WiFi Direct info\n" +
    "[o] - start OSC Server\n";  //(7)
}

void draw()
{
  background(78, 93, 75);
  if (isConfiguring) {
    info="";
    if (key == 'i')
      info = getNetInformation();  //(8)
    else if (key == 'd') {
      info = "Discovered Devices:\n";
      devices = direct.getPeerNameList();  //(9)
      for (int i=0; i < devices.size(); i++)
      {
        info += "["+i+"] "+devices.get(i).toString() + "\t\t"+devices.size()+"\n";
      }
    }
    else if (key == 'p')  {
      info += "Peers: \n";
    }
    text(UIText + "\n\n" + info, 5, 90);
  }
  else {
    pushStyle();
    noStroke();
    fill(255);
    ellipse(mouseX, mouseY, 20, 20);
    fill(255, 0, 0);
    ellipse(remoteCursor.x, remoteCursor.y, 20, 20);
    popStyle();
  }
  drawUI();
}

void mouseDragged() {
  if (isConfiguring)
    return;

  OscMessage m = new OscMessage("/remoteCursor/");
  m.add(pmouseX);
  m.add(pmouseY);

  if (oscP5 != null) {
    NetAddress myRemoteLocation = null;

    if (clientIP != "")
      myRemoteLocation = new NetAddress(clientIP, 12000);
    else if (direct.getIPAddress() != KetaiNet.getIP())
      myRemoteLocation = new NetAddress(direct.getIPAddress(), 12000);

    if (myRemoteLocation != null)
      oscP5.send(m, myRemoteLocation);
  }
}

void oscEvent(OscMessage m) {
  if (direct.getIPAddress() != m.netAddress().address())  //(10)
    clientIP = m.netAddress().address();  //(11)
  if (m.checkAddrPattern("/remoteCursor/")) {
    if (m.checkTypetag("ii")) {
      remoteCursor.x = m.get(0).intValue();
      remoteCursor.y = m.get(1).intValue();
    }
  }
}
String getNetInformation()  //(12)
{
  String Info = "Server Running: ";
  Info += "\n my IP: " + KetaiNet.getIP();
  Info += "\n initiator's IP:  " + direct.getIPAddress();
  return Info;
}
