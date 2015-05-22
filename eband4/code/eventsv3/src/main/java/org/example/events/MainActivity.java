/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.events;

import static android.provider.BaseColumns._ID;
import static org.example.events.Constants.CONTENT_URI;
// ...
import static org.example.events.Constants.TIME;
import static org.example.events.Constants.TITLE;
import android.app.ListActivity;
import android.content.ContentValues;
import android.database.Cursor;
import android.os.Bundle;
import android.widget.SimpleCursorAdapter;

public class MainActivity extends ListActivity {
   private static String[] FROM = { _ID, TIME, TITLE, };
   private static int[] TO = { R.id.rowid, R.id.time, R.id.title, };
   private static String ORDER_BY = TIME + " DESC";

   @Override
   public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main);
      addEvent("Hello, Android!");
      Cursor cursor = getEvents();
      showEvents(cursor);
   }

   private void addEvent(String string) {
      // Insert a new record into the Events data source.
      // You would do something similar for delete and update.
      ContentValues values = new ContentValues();
      values.put(TIME, System.currentTimeMillis());
      values.put(TITLE, string);
      getContentResolver().insert(CONTENT_URI, values);
   }

   private Cursor getEvents() {
      // Perform a managed query. The Activity will handle closing
      // and re-querying the cursor when needed.
      return managedQuery(CONTENT_URI, FROM, null, null, ORDER_BY);
   }

   private void showEvents(Cursor cursor) {
      // Set up data binding
      SimpleCursorAdapter adapter = new SimpleCursorAdapter(this,
            R.layout.item, cursor, FROM, TO);
      setListAdapter(adapter);
   }
}