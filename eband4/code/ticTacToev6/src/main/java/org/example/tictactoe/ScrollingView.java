/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.tictactoe;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.View;

/**
 * This custom view draws a background image that scrolls indefinitely.
 */
public class ScrollingView extends View {
   private Drawable mBackground;
   private int mScrollPos;

   public ScrollingView(Context context) {
      super(context);
      init(null, 0);
   }

   public ScrollingView(Context context, AttributeSet attrs) {
      super(context, attrs);
      init(attrs, 0);
   }

   public ScrollingView(Context context, AttributeSet attrs, int defStyle) {
      super(context, attrs, defStyle);
      init(attrs, defStyle);
   }

   private void init(AttributeSet attrs, int defStyle) {
      // Load custom view attributes
      final TypedArray a = getContext().obtainStyledAttributes(
            attrs, R.styleable.ScrollingView, defStyle, 0);

      // Get background
      if (a.hasValue(R.styleable.ScrollingView_scrollingDrawable)) {
         mBackground = a.getDrawable(
               R.styleable.ScrollingView_scrollingDrawable);
         mBackground.setCallback(this);
      }

      // Done with attributes
      a.recycle();
   }

   @Override
   protected void onDraw(Canvas canvas) {
      super.onDraw(canvas);

      // See how big the view is (ignoring padding)
      int contentWidth = getWidth();
      int contentHeight = getHeight();

      // Draw the background
      if (mBackground != null) {
         // Make the background bigger than it needs to be
         int max = Math.max(mBackground.getIntrinsicHeight(),
               mBackground.getIntrinsicWidth());
         mBackground.setBounds(0, 0, contentWidth * 4, contentHeight * 4);

         // Shift where the image will be drawn
         mScrollPos += 2;
         if (mScrollPos >= max) mScrollPos -= max;
         canvas.translate(-mScrollPos, -mScrollPos);

         // Draw it and indicate it should be drawn next time too
         mBackground.draw(canvas);
         this.invalidate();
      }
   }
}
