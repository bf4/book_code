/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.misspitts.objects;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;

public class Score implements GameObject {
  private int   value;
  private Paint paint;
  public Score() {
    value = 0;
    paint = new Paint();
    paint.setTextSize( 100 );
    paint.setTextAlign( Paint.Align.CENTER );
    paint.setAntiAlias( true );
    paint.setColor( Color.WHITE );
  }
  public void update() {
    value++;
  }
  public void paint( Canvas c ) {
    c.drawText( Integer.toString(value), 350, 220, paint );
  }

  public int getValue() {
    return value;
  }
}
