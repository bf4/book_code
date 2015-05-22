/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.graphics;

import android.app.Activity;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Path.Direction;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity {
   @Override
   public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(new GraphicsView(this));
   }

   static public class GraphicsView extends View {
         String QUOTE = "Now is the time for all "
               + "good men to come to the aid of their country.";
         Path circle;

         Paint cPaint;

         Paint tPaint;

      public GraphicsView(Context context) {
         super(context);
         // Color examples
         int color = Color.BLUE; // solid blue
         // Translucent purple
         color = Color.argb(127, 255, 0, 255);
         color = getResources().getColor(R.color.mycolor);

         circle = new Path();
         float density = getResources().getDisplayMetrics().density;
         circle.addCircle(150 * density, 150 * density,
               100 * density, Direction.CW);

         cPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
         cPaint.setColor(Color.LTGRAY);
         cPaint.setStyle(Paint.Style.STROKE);
         cPaint.setStrokeWidth(3);

         tPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
         tPaint.setStyle(Paint.Style.FILL_AND_STROKE);
         tPaint.setColor(Color.BLACK);
         float scale = getResources().getDisplayMetrics().scaledDensity;
         tPaint.setTextSize(20 * scale);

         // setBackgroundColor(Color.WHITE);
         setBackgroundResource(R.drawable.background);
      }

      @Override
      protected void onDraw(Canvas canvas) {
         // Drawing commands go here
         canvas.drawPath(circle, cPaint);
         canvas.drawTextOnPath(QUOTE, circle, 0, tPaint.getTextSize(), tPaint);
      }
   }

}