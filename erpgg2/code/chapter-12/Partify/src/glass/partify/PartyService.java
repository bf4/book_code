/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.partify;

import static glass.partify.Log.d;

import java.io.IOException;

import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Binder;
import android.os.IBinder;
import android.util.DisplayMetrics;

import com.google.android.glass.timeline.LiveCard;
import com.google.android.glass.timeline.LiveCard.PublishMode;

public class PartyService extends Service
{
  public final static String TAG          = PartyService.class.getName();

  private LiveCard           liveCard;
  private PartyDrawer        drawer;
  private final GifferBinder binder       = new GifferBinder();
  private int                balloonCount = PartyDrawer.DEFAULT_BALLOON_COUNT;

  // Binder giving access to this service.
  public class GifferBinder extends Binder {
    public PartyService getService() {
      return PartyService.this;
    }
  }
  @Override
  public IBinder onBind(Intent intent) {
    return binder;
  }
  
  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {
    d("onStartCommand");
    if (liveCard == null) {
      liveCard = new LiveCard(this, TAG);
      drawer = new PartyDrawer(this);
      liveCard.setDirectRenderingEnabled(true);
      liveCard.getSurfaceHolder().addCallback(drawer);
      liveCard.setAction(buildAction());
      liveCard.publish(PublishMode.REVEAL);
    }
    return START_STICKY;
  }
  
  private PendingIntent buildAction() {
    Intent menuIntent = new Intent(this, MenuActivity.class);
    menuIntent.addFlags(
          Intent.FLAG_ACTIVITY_NEW_TASK
        | Intent.FLAG_ACTIVITY_CLEAR_TASK);
    return PendingIntent.getActivity(this, 0, menuIntent, 0);
  }
  
  @Override
  public void onDestroy() {
    d("onDestroy");
    if( liveCard != null && liveCard.isPublished() ) {
      liveCard.getSurfaceHolder().removeCallback(drawer);
      liveCard.unpublish();
      // in case this isn't called by Android, kill the background thread
      drawer.surfaceDestroyed(liveCard.getSurfaceHolder());
      liveCard = null;
      drawer = null;
    }
    super.onDestroy();
  }
  
  public void setImageFileName(String fileName) {
    d("setImageFileName " + fileName);
    if( drawer != null ) {
      Bitmap background = BitmapFactory.decodeFile( fileName );
      DisplayMetrics dm = getResources().getDisplayMetrics();
      int width = dm.widthPixels;   // 640px
      int height = dm.heightPixels; // 360px
      background = Bitmap.createScaledBitmap( background,width,height,true );
      drawer.setBackgroundImage( background );
    }
  }
  
  public void setBalloonCount(int balloonCount) {
    d("setBalloonCount " + balloonCount);
    this.balloonCount = balloonCount;
    if (drawer != null) {
      try {
      drawer.loadBalloons(balloonCount);
      } catch (IOException e) {
        throw new RuntimeException(e);
      }
    }
  }
  public int getBalloonCount() {
    return balloonCount;
  }
}
