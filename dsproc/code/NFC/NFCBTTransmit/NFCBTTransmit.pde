/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 * <p>Updated: 2012-03-10 Daniel Sauter/j.duran</p>
 
 <intent-filter>
 <action android:name="android.nfc.action.NDEF_DISCOVERED"/>
 <category android:name="android.intent.category.DEFAULT"/>
 </intent-filter>
 
 <intent-filter>
 <action android:name="android.nfc.action.TECH_DISCOVERED"/>
 </intent-filter>
 
 <intent-filter>
 <action android:name="android.nfc.action.TAG_DISCOVERED"/>
 </intent-filter>
 
 
 <uses-permission android:name="android.permission.NFC"/>
 
 */
// Required methods to enable NFC and Bluetooth
import android.content.Intent;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;

import ketai.net.*;
import oscP5.*;
import netP5.*;

import ketai.camera.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;

KetaiCamera cam;

int divisions = 1;  //(1)
String tag="";

void setup() 
{
  orientation(LANDSCAPE);
  noStroke();
  frameRate(10);
  background(0);
  rectMode(CENTER);  //(2)
  bt.start();
  cam = new KetaiCamera(this, 640, 480, 15);
  ketaiNFC.beam("bt:"+bt.getAddress());
}

void draw() 
{
  if (cam.isStarted()) 
    interlace(cam.width/2, cam.height/2, cam.width/2, cam.height/2, divisions); //(3)

  if ((frameCount % 30) == 0)
    ketaiNFC.beam("bt:"+bt.getAddress());
}

void interlace(int x, int y, int w, int h, int level) //(4)
{
  if (level == 1)
  {
    color pixel = cam.get(x, y);  //(5)
    send((int)red(pixel), (int)green(pixel), (int)blue(pixel), x, y, w*2, h*2);  //(6)
  }

  if (level > 1) {
    level--;  //(7)
    interlace(x - w/2, y - h/2, w/2, h/2, level);  //(8)
    interlace(x - w/2, y + h/2, w/2, h/2, level);
    interlace(x + w/2, y - h/2, w/2, h/2, level);
    interlace(x + w/2, y + h/2, w/2, h/2, level);
  }
}

void onCameraPreviewEvent()
{
  cam.read();
}

void mousePressed() 
{
  if (!cam.isStarted()) 
    cam.start();

  divisions++;  //(9)
}

