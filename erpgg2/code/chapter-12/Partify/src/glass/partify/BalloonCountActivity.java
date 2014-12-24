/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.partify;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.media.AudioManager;
import android.os.Bundle;
import android.view.MotionEvent;

import com.google.android.glass.touchpad.Gesture;
import com.google.android.glass.touchpad.GestureDetector;
import com.google.android.glass.widget.CardScrollView;

public class BalloonCountActivity
    extends Activity
    implements GestureDetector.BaseListener
{
  public static final String        EXTRA_CURRENT_COUNT = "current_count";
  public static final String        EXTRA_BALLOON_COUNT = "balloon_count";
  
  private AudioManager              audioManager;
  private GestureDetector           gestureDetector;
  private CardScrollView            scrollView;
  private BalloonCountScrollAdapter adapter;
  
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    audioManager = (AudioManager)getSystemService(Context.AUDIO_SERVICE);
    gestureDetector = new GestureDetector(this).setBaseListener(this);
    // configure the adapter/view relationship
    adapter = new BalloonCountScrollAdapter(this);
    scrollView = new BalloonCountScrollView(this, gestureDetector);
    scrollView.setAdapter(adapter);  
    setContentView(scrollView);
  }
  public void onResume() {
    super.onResume();
    scrollView.activate();
    scrollView.setSelection(getIntent().getIntExtra(EXTRA_CURRENT_COUNT, 3));
  }
  public void onPause() {
    super.onPause();
    scrollView.deactivate();
  }
  // more code to come...

  @Override
  public boolean onGenericMotionEvent(MotionEvent event) {
    return gestureDetector.onMotionEvent(event);
  }
  
  @Override
  public boolean onGesture(Gesture gesture) {
    if( Gesture.TAP.equals(gesture) ) {
      int balloonCount = scrollView.getSelectedItemPosition();
      Intent result = new Intent().putExtra(EXTRA_BALLOON_COUNT, balloonCount);
      setResult(RESULT_OK, result);
      audioManager.playSoundEffect(AudioManager.FX_KEY_CLICK);
      finish();
      return true;
    }
    return false;
  }
}