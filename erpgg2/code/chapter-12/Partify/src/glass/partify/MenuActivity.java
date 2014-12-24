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

import java.io.File;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.FileObserver;
import android.os.IBinder;
import android.provider.MediaStore;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

import com.google.android.glass.content.Intents;

public class MenuActivity extends Activity
{
  private static final int  REQ_CODE_BALLOON_COUNT = 100;
  
  private static final int  REQ_CODE_TAKE_PICTURE  = 101;

  
  private FileObserver      observer;
  private boolean           waitingForResult;
  private PartyService      service;
  private ServiceConnection serviceConnection =
      new ServiceConnection() {
        public void onServiceConnected(ComponentName name, IBinder binder) {
          if (binder instanceof PartyService.GifferBinder) {
            service = ((PartyService.GifferBinder) binder).getService();
            if( hasWindowFocus() ) {
              openOptionsMenu();
            }
          }
          unbindService(this);
        }
        @Override
        public void onServiceDisconnected(ComponentName name) {}
     };

  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    bindService(new Intent(this, PartyService.class), serviceConnection, 0);
  }

  @Override
  public void onAttachedToWindow() {
    super.onAttachedToWindow();
    openOptionsMenu();
  }

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    MenuInflater inflater = getMenuInflater();
    inflater.inflate(R.menu.menu, menu);
    return true;
  }
  
  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    switch (item.getItemId()) {
    case R.id.stop:
      return stopService(new Intent(this, PartyService.class));
    case R.id.take_picture:
      Intent captureImageIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
      startActivityForResult(captureImageIntent, REQ_CODE_TAKE_PICTURE);
      waitingForResult = true;
      return true;
    case R.id.balloon_count:
      Intent balloonCountIntent = new Intent(this, BalloonCountActivity.class);
      balloonCountIntent.putExtra(
          BalloonCountActivity.EXTRA_CURRENT_COUNT,
          service.getBalloonCount());
      startActivityForResult(balloonCountIntent, REQ_CODE_BALLOON_COUNT);
      waitingForResult = true;
      return true;
    default:
      return super.onOptionsItemSelected(item);
    }
  }
  
  @Override
  public void onActivityResult(int requestCode, int resultCode, Intent intent){
    d("onActivityResult");
    if( resultCode != RESULT_OK ) {
      finish();
      return;
    }
    switch( requestCode ) {
    case REQ_CODE_TAKE_PICTURE:
      String picFilePath =
        intent.getStringExtra(Intents.EXTRA_PICTURE_FILE_PATH);
      final File pictureFile = new File(picFilePath);
      final String picFileName = pictureFile.getName();
      // set up a file observer to watch this directory on sd card
      observer = new FileObserver(pictureFile.getParentFile().getAbsolutePath()){
        public void onEvent(int event, String file) {
          d("File " + file + ", event " + event);
          if( event == FileObserver.CLOSE_WRITE && file.equals(picFileName) ) {
            d("Image file written " + file);
            service.setImageFileName(pictureFile.getAbsolutePath());
            stopWatching();
            waitingForResult = false;
            finish();
          }
        }
      };
      observer.startWatching();
      waitingForResult = false;
      return;
    case REQ_CODE_BALLOON_COUNT:
      int balloonCount =
        intent.getIntExtra(BalloonCountActivity.EXTRA_BALLOON_COUNT, 3);
      service.setBalloonCount(balloonCount);
      waitingForResult = false;
      finish();
      return;
    default:
      finish();
    }
  }

  @Override
  public void onOptionsMenuClosed(Menu menu) {
    if( !waitingForResult ) {
      finish();
    }
  }
}
