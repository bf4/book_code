/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.partify;

import java.io.IOException;
import java.io.InputStream;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

public class Balloon {
  enum Color {
    GREEN("green"), YELLOW("yellow"), RED("red");
    // ...skipping basic enum methods
    private final String color;
    
    private Color(final String color) {
      this.color = color;
    }
    
    @Override
    public String toString() {
      return color;
    }
  }

  private Bitmap balloonImage;
  private int left;
  private int top;
  private int initialTop;
  private int endTop;
  private int speed;

  public Balloon(Context context, String color, double percentSize,
                 int initialLeft, int initialTop)
    throws IOException {
    // get a bitmap asset and resize it
    String filename = color + "_balloon.png";
    InputStream stream = context.getAssets().open(filename);
    Bitmap image = BitmapFactory.decodeStream(stream);
    int width = (int)(image.getWidth() * percentSize);
    int height = (int)(image.getHeight() * percentSize);
    balloonImage = Bitmap.createScaledBitmap(image,width,height,true);

    this.left = initialLeft;
    this.top = this.initialTop = initialTop;
    // restart when the balloon when it reaches past the screen
    this.endTop = -height;
    // give the balloon a speed related to size
    this.speed = (int)(10 * percentSize)+1;
  }
  // ...skipping other helper methods

	public Bitmap getBitmap() {
		return balloonImage.isRecycled() ? null : balloonImage;
	}

	public int nextLeft() {
		return left;
	}

	public int nextTop() {
		// move up until it's entire height passes 0, then restart to initial
		if( (top -= speed) <= endTop ) {
			top = initialTop;
		}
		return top;
	}
}
