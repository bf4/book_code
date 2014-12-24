/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.qr;

import java.io.IOException;

import android.annotation.SuppressLint;
import android.hardware.Camera;
import android.hardware.Camera.Parameters;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.widget.Toast;

import com.google.android.glass.timeline.DirectRenderingCallback;

/**
 * @author eric redmond
 * @twitter coderoshi
 */
@SuppressLint("ViewConstructor")
public class QRCameraView
  extends SurfaceView
  implements DirectRenderingCallback
{
  public final static String TAG = QRCameraView.class.getName();
  public static final int    FPS = 30;

  private Camera camera;

  public QRCameraView( QRCameraActivity context ) {
    super(context);
    getHolder().addCallback(this);
  }

  
  public void surfaceCreated(SurfaceHolder holder) {}

  public void surfaceChanged(SurfaceHolder holder, int format,
                             int width, int height) {
    Log.d(TAG, "surfaceChanged");
    this.camera = openCamera(holder);
    Log.d(TAG, "setPreviewDisplay:" + holder.getSurface());
    this.camera.startPreview();
  }
  
  public void surfaceDestroyed(SurfaceHolder holder) {
    Log.d(TAG, "surfaceDestroyed");
    releaseCamera();
  }
  
  public void renderingPaused(SurfaceHolder holder, boolean paused) {
    if (paused) {
      Log.d(TAG, "renderingPaused PAUSED");
      releaseCamera();
    } else {
      Log.d(TAG, "renderingPaused UNPAUSED");
      if (holder.getSurface().isValid()) {
        this.camera = openCamera(holder);
        this.camera.startPreview();
      }
    }
  }
  
  private Camera openCamera(SurfaceHolder holder) {
    if (this.camera != null)
      return this.camera;
    Camera camera = Camera.open();
    try {
      // Glass camera patch
      Parameters params = camera.getParameters();
      params.setPreviewFpsRange(FPS * 1000, FPS * 1000);
      final DisplayMetrics dm = getContext().getResources().getDisplayMetrics();
      params.setPreviewSize(dm.widthPixels, dm.heightPixels); // 640, 360
      camera.setParameters(params);
      camera.setPreviewDisplay(holder);
      QRCameraActivity activity = (QRCameraActivity)getContext();
      camera.setPreviewCallback(
        new QRPreviewScan(activity, dm.widthPixels, dm.heightPixels));
    } catch (IOException e) {
      camera.release();
      camera = null;
      Toast.makeText(getContext(), e.getMessage(), Toast.LENGTH_LONG).show();
      e.printStackTrace();
    }
    return camera;
  }

  private synchronized void releaseCamera() {
    if (this.camera != null) {
      try {
        this.camera.setPreviewDisplay(null);
      } catch (IOException e) {}
      this.camera.setPreviewCallback(null);
      this.camera.stopPreview();
      this.camera.release();
      this.camera = null;
    }
  }
}
