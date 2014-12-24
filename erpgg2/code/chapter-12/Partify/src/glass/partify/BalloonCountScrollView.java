/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.partify;

import android.content.Context;
import android.view.MotionEvent;

import com.google.android.glass.touchpad.GestureDetector;
import com.google.android.glass.widget.CardScrollView;

public class BalloonCountScrollView extends CardScrollView {
  // NOTE: this is not a android.view.GestureDetector class
  private GestureDetector gestureDetector;
  
  public BalloonCountScrollView(Context context, GestureDetector gestureDetector) {
    super( context );
    this.gestureDetector = gestureDetector;
  }
  
  public boolean dispatchGenericFocusedEvent(MotionEvent event) {
    if( gestureDetector.onMotionEvent(event) ) { return true; }
    return super.dispatchGenericFocusedEvent(event);
  }
}
