/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.qr;

import android.content.Intent;
import android.hardware.Camera;
import android.util.Log;

import com.google.zxing.BinaryBitmap;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.PlanarYUVLuminanceSource;
import com.google.zxing.ReaderException;
import com.google.zxing.Result;
import com.google.zxing.common.HybridBinarizer;

public class QRPreviewScan implements Camera.PreviewCallback {
  public final static String TAG = QRPreviewScan.class.getName();
  private static final int   SCANS_PER_SEC = 3;
  private int                framesSinceLastScan;
  private int                widthPixels;
  private int                heightPixels;
  private MultiFormatReader  multiFormatReader;
  private QRCameraActivity   activity;

  public QRPreviewScan(QRCameraActivity activity, int widthPixels, int heightPixels) {
    this.framesSinceLastScan = 0;
    this.activity = activity;
    this.widthPixels = widthPixels;
    this.heightPixels = heightPixels;
    this.multiFormatReader = new MultiFormatReader();
  }

  public void onPreviewFrame(byte[] data, Camera camera) {
    // Only scan every 10th frame
    if( ++framesSinceLastScan % (QRCameraView.FPS / SCANS_PER_SEC) == 0 ) {
      scan(data, widthPixels, heightPixels);
      framesSinceLastScan = 0;
    }
  }

  /*
  private static AtomicBoolean scanning = new AtomicBoolean(false);
  class ScanTask extends AsyncTask<PlanarYUVLuminanceSource, Result, Result> {
    @Override
    protected Result doInBackground( PlanarYUVLuminanceSource... params ) {
      if( scanning.getAndSet(true) ) return null;
      PlanarYUVLuminanceSource luminanceSource = params[0];
      BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));
      try {
        return multiFormatReader.decodeWithState(bitmap);
      } catch (ReaderException re) { // nothing found to decode
      } finally {
        multiFormatReader.reset();
      }
      scanning.set(false);
      return null;
    }
    @Override
    protected void onPostExecute(Result result) {
      if( result != null ) {
        Intent intent = new QRIntentBuilder(result.getText()).buildIntent();
        activity.launchIntent(intent);
        scanning.set(false);
      }
    }
  }
  //*/

  private void scan(byte[] data, int width, int height) {
    Log.d(TAG, "scan");
    PlanarYUVLuminanceSource luminanceSource = new PlanarYUVLuminanceSource(data,
        width, height, 0, 0, width, height, false);
    // new ScanTask().execute(luminanceSource); // uncomment to use ScanTask
    BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));
    Result result = null;
    try {
      result = multiFormatReader.decodeWithState(bitmap);
    } catch (ReaderException re) { // nothing found to decode
    } finally {
      multiFormatReader.reset();
    }
    if (result != null) {
      Intent intent = new QRIntentBuilder(result.getText()).buildIntent();
      activity.launchIntent(intent);
    }
  }
}
