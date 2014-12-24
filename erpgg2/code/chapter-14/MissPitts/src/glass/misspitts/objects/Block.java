/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.misspitts.objects;

import glass.misspitts.GameEngine;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Rect;

public class Block implements GameObject {
  enum Type { BLOCK, PIT }
  public static final int BLOCK_SIZE = 40;

  private static final int SCREEN_SIZE = 360;
  public static Bitmap bitmapAsset;

  private int  count, height, x, y, speedX;
  private Type type;
  private Rect boundary;
  private Rect middleBoundary;
  private boolean   pointGiven, middle;
  private MissPitts missPitts;

  public Block( int positionInLevel, int count, Type type, MissPitts player ) {
    this.type = type;
    this.count = count;
    missPitts = player;
    height = type == Type.PIT ? SCREEN_SIZE : BLOCK_SIZE;
    y = SCREEN_SIZE - height;
    x = positionInLevel * BLOCK_SIZE;
    boundary = new Rect();
    middleBoundary = new Rect();
  }
  public void update() {
    // blocks move in the opposite direction of the player
    speedX = -missPitts.getSpeedX();
    x += speedX;
    boundary.set(x, y, x + count*BLOCK_SIZE, y + height);
    // detect ground collision
    if(type == Type.BLOCK && Rect.intersects(boundary, missPitts.getBoundary())) {
      // stop the player from falling beyond the top of the block
      missPitts.setJumped( false );
      missPitts.setSpeedY( 0 );
      missPitts.setCenterY( y - MissPitts.HEIGHT/2 );
      // give one point per block landed on after a pit
      if( !pointGiven ) {
        missPitts.getScore().update();
        pointGiven = true;
      }
    }
    // when player crosses above a level's middle block,
    // create the next level. @see code in Block.java
    if( middle ) {
      middleBoundary.set(x, 0, x+(count*BLOCK_SIZE), SCREEN_SIZE);
      if( Rect.intersects( middleBoundary, missPitts.getBoundary() ) ) {
        synchronized( GameEngine.class ) {
          GameEngine.setupNextLevel();
          middle = false;
        }
      }
    }
  }
  public void paint( Canvas c ) {
    if( type == Type.PIT ) return;
    for( int i = 0; i < count; i++ ) {
      c.drawBitmap( bitmapAsset, x + (i * BLOCK_SIZE), y, null );
    }
  }

  public void addWidth( int width ) {
    this.count += width;
  }

  public Type getType() {
    return type;
  }

  public int getCount() {
    return count;
  }

  public int getX() {
    return x;
  }

  public void setMiddle( boolean middle ) {
    this.middle = middle;
  }
  
  public void setPointGiven( boolean pointGiven ) {
    this.pointGiven = pointGiven;
  }
}