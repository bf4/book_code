/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai NFC Features:
 * <ul>
 * <li>handles incoming Near Field Communication Events</li>
 * </ul>
 * <p>Note:
 * Add the following within the sketch activity to the AndroidManifest.xml:
 * 
 * <uses-permission android:name="android.permission.NFC" /> 
 *
 * <intent-filter>
 *   <action android:name="android.nfc.action.TECH_DISCOVERED"/>
 * </intent-filter>
 *
 * <intent-filter>
 *  <action android:name="android.nfc.action.NDEF_DISCOVERED"/>
 * </intent-filter>
 *
 * <intent-filter>
 *  <action android:name="android.nfc.action.TAG_DISCOVERED"/>
 *  <category android:name="android.intent.category.DEFAULT"/>
 * </intent-filter>
 *
 * </p> 
 * <p>Updated: 2012-03-10 Daniel Sauter/j.duran</p>
 */
// Required NFC methods on startup
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;

import ketai.net.nfc.*;

String tagText = "";
KetaiNFC ketaiNFC;

void setup() {   
  ketaiNFC = new KetaiNFC(this);
  orientation(LANDSCAPE);
  textSize(36);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(78, 93, 75);
  text("Tag:\n"+ tagText, width/2, height/2);  //(1)
}

void onNFCEvent(String txt) { //(2)
  tagText = trim(txt); //(3)
}

void mousePressed() {
  if (tagText.indexOf("http://") == 0) //(4)
    link(tagText);  //(5)
}
