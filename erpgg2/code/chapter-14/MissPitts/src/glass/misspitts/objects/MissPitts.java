/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.misspitts.objects;

import glass.misspitts.RenderView;

import java.util.ArrayList;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Rect;

public class MissPitts implements GameObject {
  public static final int HEIGHT = 126;
  public static final int SINGLE_JUMP = -15, DOUBLE_JUMP = -20, TRIPLE_JUMP = -28;
  public static final int WALK_SPEED = 5, RUN_SPEED = 8;
  public static Bitmap bitmapAsset1, bitmapAsset2;

  private Score     score;
  private Rect      boundary;
  private int       centerX, centerY;
  private int       speedX, speedY;
  private boolean   movingRight, jumped;
  private MissPittsAnimator  animatedWalking;

  public MissPitts( Score score ) {
    this.score = score;
    boundary = new Rect();
    centerX  = 100;
    centerY  = 100; // drops from the sky
    // animates steps for a quarter of a second
    animatedWalking = new MissPittsAnimator( 250 );
  }
  public void update() {
    if( speedX < 0 ) centerX += speedX;
    if( centerX <= 200 && speedX > 0 ) centerX += speedX;
    centerY += speedY;
    speedY += 1;
    if( speedY > 3 ) jumped = true;
    // The player's bounding rectangle for collision detection
    boundary.set( centerX - 35, centerY, centerX, centerY + 70 );
    // update the animator tick to create an animation illusion
    animatedWalking.update( RenderView.MSPF );
  }
  public void paint( Canvas c ) {
    // choose which player image to show
    final Bitmap sprite;
    if( jumped ) {            sprite = MissPitts.bitmapAsset2; }
    else if( !movingRight ) { sprite = MissPitts.bitmapAsset1; }
    else {                    sprite = animatedWalking.getImage(); }
    c.drawBitmap( sprite, centerX - 61, centerY-HEIGHT/2, null );
  }

  public Score getScore() {
    return score;
  }
  
  public Rect getBoundary() {
    return boundary;
  }
  
  public void moveRight(int moveSpeed) {
    speedX = moveSpeed;
    movingRight = true;
  }

  public void stopRight() {
    movingRight = false;
    speedX = 0;
  }

  public void jump(int jumpSpeed) {
    if( !jumped ) {
      speedY = jumpSpeed;
      jumped = true;
    }
  }

  public int getCenterY() {
    return centerY;
  }

  public boolean isJumped() {
    return jumped;
  }

  public int getSpeedX() {
    return speedX;
  }

  public void setCenterY(int centerY) {
    this.centerY = centerY;
  }

  public void setJumped(boolean jumped) {
    this.jumped = jumped;
  }
  
  public void setSpeedY(int speedY) {
    this.speedY = speedY;
  }

  public boolean isMovingRight() {
    return movingRight;
  }

  /**
   * Animator tracks the which image is active between a series of images
   * for some specified delay to create an illusion of walking
   */
  public class MissPittsAnimator {
    private int  currentPos;
    private long sequenceTime;
    private long totalSequenceTime;
    private ArrayList<Frame> frames;

    public MissPittsAnimator(int frameTime) {
      frames = new ArrayList<Frame>();
      sequenceTime = 0;
      currentPos = 0;
      frames.add(new Frame( MissPitts.bitmapAsset1, totalSequenceTime += frameTime));
      frames.add(new Frame( MissPitts.bitmapAsset2, totalSequenceTime += frameTime));
    }

    public synchronized void update( long elapsedTime ) {
      if( frames.isEmpty() ) return;
      sequenceTime += elapsedTime;
      if( sequenceTime >= totalSequenceTime ) {
        sequenceTime = sequenceTime % totalSequenceTime;
        currentPos = 0;
      }
      // skip to best matching frame
      while(sequenceTime > frames.get(currentPos).stopTime) currentPos++;
    }

    public synchronized Bitmap getImage() {
      return frames.isEmpty() ? null : frames.get(currentPos).image;
    }

    private class Frame {
      Bitmap image;
      long   stopTime;
      public Frame( Bitmap image, long stopTime ) {
        this.image = image;
        this.stopTime = stopTime;
      }
    }
  }
}