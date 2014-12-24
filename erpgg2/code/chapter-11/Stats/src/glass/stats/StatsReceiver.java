/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.stats;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.wifi.WifiManager;
import android.widget.RemoteViews;

import com.google.android.glass.timeline.LiveCard;

public class StatsReceiver extends BroadcastReceiver {
	private LiveCard liveCard;
	private RemoteViews rv;

	public StatsReceiver( LiveCard liveCard, RemoteViews rv ) {
		this.liveCard = liveCard;
		this.rv = rv;
	}

  // you can replace these values with any information you want about your glass
  @Override
  public void onReceive(Context context, Intent intent) {
    // set the current time no matter what
    rv.setTextViewText(R.id.time, StatsUtil.getCurrentTime(context));

    // if connection status changes, set it
    if (Intent.ACTION_POWER_CONNECTED.equals(intent.getAction())) {
      rv.setTextViewText(R.id.connected, context.getString(R.string.connected));
    }
    if (Intent.ACTION_POWER_DISCONNECTED.equals(intent.getAction())) {
      rv.setTextViewText(R.id.connected, context.getString(R.string.disconnected));
    }

    // if a battery value changes, update them all
    if (Intent.ACTION_BATTERY_CHANGED.equals(intent.getAction())) {
      rv.setTextViewText(R.id.battery_degrees, StatsUtil.getDegrees(intent) + "C");
      rv.setTextViewText(R.id.battery_voltage, StatsUtil.getVoltage(intent) + "V");
      rv.setProgressBar(R.id.battery_level, 100,
          StatsUtil.getBatteryLevel(intent), false);
    }

    if (WifiManager.NETWORK_STATE_CHANGED_ACTION.equals(intent.getAction())) {
      rv.setImageViewResource(R.id.wifi_strength,
          StatsUtil.getWifiIconResource(context));
    }
  
    // inform the livecard of the changes to the views
    liveCard.setViews(rv);
  }
}