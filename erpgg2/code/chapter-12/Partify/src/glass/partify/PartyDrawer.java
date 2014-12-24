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
import java.util.Random;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.view.SurfaceHolder;

import com.google.android.glass.timeline.DirectRenderingCallback;

public class PartyDrawer implements DirectRenderingCallback {
  public static final int DEFAULT_BALLOON_COUNT = 3;
  /**
   * This is a thread that runs in a loop, and will continue drawing frames until
   * it's told to pause or stop entirely.
   */
  class DrawFrameThread extends Thread {
    private static final int FPS = 24;
    private boolean running;
    private boolean pause;
    public void run() {
      d("startRun");
      pause = false;
      running = true;
      while( running ) {
        if( !pause )  draw();
        try {
        Thread.sleep(1000 / FPS);
        } catch (InterruptedException e) {}
      }
    }
    public void pause(boolean pause) {
      this.pause = pause;
    }
    public void exit() {
      pause = true;
      running = false;
      while( true ) {
      try {
      join();
      break;
      } catch (InterruptedException e) {}
      }
    }
  }
  
  private Context         context;
  private SurfaceHolder   holder;
  private DrawFrameThread thread;
  private Bitmap          backgroundBitmap;
  private Balloon[] balloons;
  
  public PartyDrawer(Context context) {
    this.context = context;
  }
  public void surfaceCreated(SurfaceHolder holder) {
    d("surfaceCreated");
    this.holder = holder;
    this.thread = new DrawFrameThread();
    try {
    loadBalloons(DEFAULT_BALLOON_COUNT);
    } catch(IOException e) {
      e.printStackTrace();
    }
    this.thread.start();
  }
  public void surfaceChanged(SurfaceHolder holder, int format, int w, int h) {
    // nothing to do here
    d("surfaceChanged");
  }
  public void renderingPaused(SurfaceHolder surfaceholder, boolean pause) {
    d("renderingPaused " + pause);
    this.thread.pause(pause);
  }
  public void surfaceDestroyed(SurfaceHolder holder) {
    d("surfaceDestroyed");
    this.thread.exit();
    this.thread = null;
    this.holder = null;
  }
  // there's more code coming...

  public void setBackgroundImage(Bitmap background) {
    this.backgroundBitmap = background;
    d("backgroundBitmap " + (this.backgroundBitmap != null));
  }


  public synchronized void loadBalloons(int balloonCount) throws IOException {
    if( thread != null )  thread.pause(true);
    balloons = new Balloon[balloonCount];
    Random rand = new Random();
    for( int i = 0; i < balloonCount; i++ ) {
      // what color balloon
      Balloon.Color[] colors = Balloon.Color.values();
      String color = colors[rand.nextInt(colors.length)].toString();
      // what size should the balloon be
      double percentSize = rand.nextDouble();
      // how far left to does the balloon rise
      int left = rand.nextInt(640);
      balloons[i] = new Balloon(context, color, percentSize, left, 360);
    }
    if( thread != null )  thread.pause(false);
  }

  private void draw() {
    if( this.balloons == null ) { return; }
    final Canvas canvas;
    try {
      canvas = this.holder.lockCanvas();
    } catch (Exception e) { return; }
    if( canvas == null ) { return; }
    synchronized( PartyDrawer.this ) {
      canvas.drawColor( Color.BLACK );
      // ...after we paint the canvas black with drawColor...
      if( this.backgroundBitmap != null ) {
        canvas.drawBitmap( this.backgroundBitmap, 0, 0, null );
      }
      // ...now render the balloons overtop the image...
      for( int i = 0; i < this.balloons.length; i++ ) {
        Balloon b = this.balloons[i];
        if( b.getBitmap() != null ) {
          canvas.drawBitmap( b.getBitmap(), b.nextLeft(), b.nextTop(), null );
        }
      }
    }
    this.holder.unlockCanvasAndPost( canvas );
  }
}
