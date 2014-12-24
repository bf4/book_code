/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.simple;

import android.app.Activity;
import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.CalendarContract.Calendars;
import android.util.Log;
import android.view.View;

import com.google.android.glass.widget.CardBuilder;
import com.google.android.glass.widget.CardBuilder.Layout;

public class MainActivity extends Activity {
  private View cardView;
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    CardBuilder card = new CardBuilder(this, Layout.TEXT)
      .setText("Hello World")
      .setFootnote("This is from an Activity");
    cardView = card.getView();
    setContentView(cardView);
  }

  public static final String[] EVENT_PROJECTION = new String[] {
     Calendars._ID,                   // 0
     Calendars.CALENDAR_DISPLAY_NAME  // 1
  };
  private static final int PROJECTION_ID_INDEX = 0;
  private static final int PROJECTION_DISPLAY_NAME_INDEX = 1;
  protected void onResume() {
    super.onResume();
    ContentResolver cr = getContentResolver();
    Uri uri = Calendars.CONTENT_URI;  // "content://com.android.calendar/calendars"
    String selection = "(" + Calendars.OWNER_ACCOUNT + " = ?)";
    String[] selectionArgs = new String[] {"eric.redmond@gmail.com"}; 
    // Submit the query and get a Cursor object back. 
    Cursor cur = cr.query(uri, EVENT_PROJECTION, selection, selectionArgs, null);
    // Use the cursor to step through the returned records
    while( cur.moveToNext() ) {
      // Get the field values
      long calID = cur.getLong( PROJECTION_ID_INDEX );
      String displayName = cur.getString( PROJECTION_DISPLAY_NAME_INDEX );
      Log.i("glass.simple", "calID: " + calID + ", displayName: " + displayName);
    }
  }
  protected void onDestroy() {
    super.onDestroy();
    cardView = null;
  }
}
