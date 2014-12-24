/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.qr;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Style;
import android.media.AudioManager;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.FrameLayout;

import com.google.android.glass.widget.CardBuilder;
import com.google.android.glass.widget.CardBuilder.Layout;

/**
 * @author eric redmond
 * @twitter coderoshi
 */
public class QRCameraActivity
  extends Activity
{
  public final static String TAG = QRCameraActivity.class.getName();

  private static final int REQUEST_CODE = 100;

  private QRCameraView       cameraView;
  private View               overlayView;
  private FrameLayout        layout;
  private AudioManager       audioManager;

  static class OverlayView extends View {
    private Paint paint;
    private String overlay;
    public OverlayView(Context context) {
      super(context);
      this.paint = new Paint( Paint.ANTI_ALIAS_FLAG );
      this.overlay = this.getResources().getString(R.string.qr_camera_overlay);
    }
    public void draw( Canvas canvas ) {
      // draw drop shadows
      paint.setColor( Color.BLACK );
      drawBox( canvas, 1 );
      drawText( canvas, 1 );
      // draw box and text
      paint.setColor( Color.WHITE );
      drawBox( canvas, 0 );
      drawText( canvas, 0 );
    }
    private void drawBox( Canvas canvas, int offset ) {
      paint.setStrokeWidth( 6 );
      paint.setStyle( Style.STROKE );
      canvas.drawRect( 40-offset, 40-offset, 600+offset, 320+offset, paint );
    }
    private void drawText( Canvas canvas, int offset ) {
      // paint.setTypeface( Typeface.create("Roboto", 0) );
      paint.setTextSize( 32 );
      canvas.drawText( this.overlay, 90+offset, 300+offset, paint );
    }
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    Log.d(TAG, "onCreate");
    super.onCreate(savedInstanceState);
    audioManager = (AudioManager)getSystemService(Context.AUDIO_SERVICE);
    cameraView = new QRCameraView( this );
    overlayView = new OverlayView( this );
    layout = new FrameLayout( this );
    layout.setKeepScreenOn( true );
    layout.addView( cameraView );  // order is important here
    layout.addView( overlayView ); // the last view is on top
    setContentView( layout );
  }

  @Override
  protected void onPause() {
    Log.d(TAG, "onPause");
    cameraView.renderingPaused(cameraView.getHolder(), true);
    super.onPause();
  }

  @Override
  public boolean onKeyDown(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_CAMERA) {
      // Release the camera by pausing the cameraView
      cameraView.renderingPaused(cameraView.getHolder(), true);
      return false;  // propgate this click onward
    }
    else if (keyCode == KeyEvent.KEYCODE_DPAD_CENTER) {
      audioManager.playSoundEffect(AudioManager.FX_KEY_CLICK);
      openOptionsMenu();
      return true;
    }
    else {
      return super.onKeyDown(keyCode, event);
    }
  }


  @Override
  protected void onResume() {
    Log.d(TAG, "onResume");
    super.onResume();
    // Re-acquire the camera and start the preview.
    cameraView.renderingPaused(cameraView.getHolder(), false);
  }

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    MenuInflater inflater = getMenuInflater();
    inflater.inflate(R.menu.qr, menu);
    return true;
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    switch (item.getItemId()) {
    case R.id.stop:
      finish();
      return true;
    default:
      return super.onOptionsItemSelected(item);
    }
  }
  
  public synchronized void launchIntent(Intent intent) {
    Log.d(TAG, "launchIntent");
    cameraView.renderingPaused(cameraView.getHolder(), true);
    if (intent.hasExtra("text")) {
      // no intent to launch, just show the text
      CardBuilder card = new CardBuilder(this, Layout.TEXT)
        .setText(intent.getStringExtra("text"));
      layout.removeAllViews();
      layout.addView( card.getView() );
    } else {
      startActivityForResult(intent, REQUEST_CODE);
    }
  }

  public void onActivityResult(int requestCode, int resultCode, Intent intent) {
    Log.d(TAG, "requestCode=" + requestCode + ",resultCode=" + resultCode);
    switch (requestCode) {
    case REQUEST_CODE:
      finish();
      break;
    default:
      break;
    }
  }
}
