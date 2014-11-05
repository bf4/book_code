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
import android.os.Bundle;  //(1)
import android.content.Intent;  //(2)

import ketai.net.bluetooth.*;  
import ketai.ui.*; 
import ketai.net.*;
import oscP5.*;

KetaiBluetooth bt;  //(3)

KetaiList connectionList;  //(4)
String info = "";  //(5)
PVector remoteCursor = new PVector();
boolean isConfiguring = true;
String UIText;

void setup()
{   
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textSize(24);

  bt.start(); //(6)

  UIText =  "[b] - make this device discoverable\n" +  //(7)
    "[d] - discover devices\n" +
    "[c] - pick device to connect to\n" +
    "[p] - list paired devices\n" +
    "[i] - show Bluetooth info";
}

void draw()
{
  if (isConfiguring)
  {
    ArrayList<String> devices; //(8)
    background(78, 93, 75);

    if (key == 'i')
      info = getBluetoothInformation(); //(9)
    else
    {
      if (key == 'p')
      {
        info = "Paired Devices:\n";
        devices = bt.getPairedDeviceNames(); //(10)
      }
      else
      {
        info = "Discovered Devices:\n";
        devices = bt.getDiscoveredDeviceNames(); //(11)
      }

      for (int i=0; i < devices.size(); i++)
      {
        info += "["+i+"] "+devices.get(i).toString() + "\n";  //(12)
      }
    }
    text(UIText + "\n\n" + info, 5, 90);
  }
  else
  {
    background(78, 93, 75);
    pushStyle();
    fill(255);
    ellipse(mouseX, mouseY, 20, 20);
    fill(0, 255, 0);
    stroke(0, 255, 0);
    ellipse(remoteCursor.x, remoteCursor.y, 20, 20); //(13)
    popStyle();
  }

  drawUI();
}

void mouseDragged()
{
  if (isConfiguring)
    return;

  OscMessage m = new OscMessage("/remoteMouse/"); //(14)
  m.add(mouseX);
  m.add(mouseY);

  bt.broadcast(m.getBytes());  //(15)
  // use writeToDevice(String _devName, byte[] data) to target a specific device
  ellipse(mouseX, mouseY, 20, 20);
}

void onBluetoothDataEvent(String who, byte[] data) //(16)
{
  if (isConfiguring)
    return;

  KetaiOSCMessage m = new KetaiOSCMessage(data); //(17)
  if (m.isValid())
  {
    if (m.checkAddrPattern("/remoteMouse/"))
    {
      if (m.checkTypetag("ii")) //(18)
      {
        remoteCursor.x = m.get(0).intValue();
        remoteCursor.y = m.get(1).intValue();
      }
    }
  }
}

String getBluetoothInformation()  //(19)
{
  String btInfo = "Server Running: ";
  btInfo += bt.isStarted() + "\n";
  btInfo += "Device Discoverable: "+bt.isDiscoverable() + "\n";
  btInfo += "\nConnected Devices: \n";

  ArrayList<String> devices = bt.getConnectedDeviceNames(); //(20)
  for (String device: devices)
  {
    btInfo+= device+"\n";
  }

  return btInfo;
}

