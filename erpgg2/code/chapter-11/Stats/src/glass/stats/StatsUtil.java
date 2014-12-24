/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.stats;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.net.wifi.WifiManager;
import android.os.BatteryManager;
import android.provider.Settings;
import android.util.Log;

public final class StatsUtil
{
  public static String getConnectedString( Context context ) {
    // ACTION_BATTERY_CHANGED is a "sticky" intent, it's always active
    Intent intent = 
        context.registerReceiver(null,
            new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
    if( intent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1) ==
        BatteryManager.BATTERY_PLUGGED_USB ) {
      return context.getString(R.string.connected);
    } else {
      return context.getString(R.string.disconnected);
    }
  }

  public static String getCurrentTime( Context context ) {
    Configuration config = context.getResources().getConfiguration();
    return new SimpleDateFormat("HH:mm", config.locale)
      .format(Calendar.getInstance().getTime());
  }

  public static float getDegrees( Intent intent ) {
    // EXTRA_TEMPERATURE is the battery temperature in tenths of a degree C
    return intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0) / 10;
  }

  public static float getVoltage( Intent intent ) {
    // EXTRA_VOLTAGE is the battery voltage in millivolts
    return (float)intent.getIntExtra(BatteryManager.EXTRA_VOLTAGE, 0) / 1000;
  }

  public static int getBatteryLevel( Intent intent ) {
    // EXTRA_SCALE gives EXTRA_LEVEL a maximum battery level
    int scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, 100);
    float level = (float)intent.getIntExtra(BatteryManager.EXTRA_LEVEL, 0) / scale;
    Log.d("StatsUtil", "power: " + (int)level * 100);
    return (int)level * 100;
  }

  public static int getWifiIconResource( Context context ) {
    ContentResolver cr = context.getContentResolver();
    boolean wifiOn = Settings.Global.getInt(cr, Settings.Global.WIFI_ON, 0) == 1;
    if( wifiOn ) {
      WifiManager wifiManager = (WifiManager)context.getSystemService(Context.WIFI_SERVICE);
      int rssi = wifiManager.getConnectionInfo().getRssi();
      int strength = WifiManager.calculateSignalLevel(rssi, 4) + 1;
      // strength associate with an icon number
      int wifiIconResource = R.drawable.ic_wifi_1;
      switch(strength) {
      case 1:  wifiIconResource = R.drawable.ic_wifi_1; break;
      case 2:  wifiIconResource = R.drawable.ic_wifi_2; break;
      case 3:  wifiIconResource = R.drawable.ic_wifi_3; break;
      case 4:  wifiIconResource = R.drawable.ic_wifi_4; break;
      default: wifiIconResource = R.drawable.ic_wifi_1;
      }
      // return icon as a representation of signal strength
      return wifiIconResource;
    } else {
      // wifi is not enabled
      return R.drawable.ic_stop;
    }
  }
}
