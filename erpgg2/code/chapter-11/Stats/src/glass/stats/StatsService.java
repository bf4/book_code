/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.stats;

import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.net.wifi.WifiManager;
import android.os.IBinder;
import android.util.Log;
import android.widget.RemoteViews;

import com.google.android.glass.timeline.LiveCard;
import com.google.android.glass.timeline.LiveCard.PublishMode;

public class StatsService extends Service
{
  public final static String TAG = StatsService.class.getName();

  private StatsReceiver receiver;
  private LiveCard      liveCard;
  private RemoteViews   rv;

  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {
    if( liveCard == null ) {
      Log.d( TAG, "Creating LiveCard" );
      liveCard = new LiveCard( this, TAG );
      liveCard.setViews( remoteViews() );
      liveCard.setAction( buildAction() );
      liveCard.publish( PublishMode.REVEAL );
      buildReceiver( remoteViews() );
    }
    return START_STICKY;
  }
  
  @Override
  public void onDestroy() {
    if( liveCard != null && liveCard.isPublished() ) {
      liveCard.unpublish();
      liveCard = null;
      unregisterReceiver(receiver);
    }
    super.onDestroy();
  }

  private RemoteViews remoteViews() {
    if( this.rv == null ) {
    rv = new RemoteViews(getPackageName(), R.layout.stats);
    rv.setTextViewText(R.id.time, StatsUtil.getCurrentTime(this));
    rv.setTextViewText(R.id.connected, StatsUtil.getConnectedString(this));
    Configuration config = getResources().getConfiguration();
    rv.setTextViewText(R.id.language, config.locale.getDisplayLanguage());
    rv.setTextViewText(R.id.country, config.locale.getDisplayCountry());
    rv.setProgressBar(R.id.battery_level, 100, 100, false);
    }
    return rv;
  }

  private PendingIntent buildAction() {
    Intent menuIntent = new Intent(this, MenuActivity.class);
    menuIntent.addFlags(
          Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
    return PendingIntent.getActivity(this, 0, menuIntent, 0);
  }

  private void buildReceiver(RemoteViews rv) {
    IntentFilter filter = new IntentFilter();
    filter.addAction(Intent.ACTION_POWER_CONNECTED);
    filter.addAction(Intent.ACTION_POWER_DISCONNECTED);
    filter.addAction(Intent.ACTION_CONFIGURATION_CHANGED);
    filter.addAction(Intent.ACTION_BATTERY_CHANGED);
    filter.addAction(Intent.ACTION_TIME_TICK); // update every minute
    filter.addAction(WifiManager.NETWORK_STATE_CHANGED_ACTION);
    receiver = new StatsReceiver(liveCard, rv);
    registerReceiver(receiver, filter);
  }

  @Override
  public IBinder onBind(Intent intent) {
    return null;
  }

  LiveCard getLiveCard() {
    return liveCard;
  }
}
