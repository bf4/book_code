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
import static org.example.events.Constants.TIME;
import static org.example.events.Constants.TITLE;
import android.app.ListActivity;
import android.app.LoaderManager;
import android.content.ContentValues;
import android.content.CursorLoader;
import android.content.Loader;
import android.database.Cursor;
import android.os.Bundle;
import android.widget.SimpleCursorAdapter;

public class MainActivity extends ListActivity implements
      LoaderManager.LoaderCallbacks<Cursor> {
   // ...
   private static String[] FROM = { _ID, TIME, TITLE, };
   private static int[] TO = { R.id.rowid, R.id.time, R.id.title, };
   private static String ORDER_BY = TIME + " DESC";

   // The loader's unique id (within this activity)
   private final static int LOADER_ID = 1;

   // The adapter that binds our data to the ListView
   private SimpleCursorAdapter mAdapter;

   @Override
   public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main);

      // Initialize the adapter. It starts off empty.
      mAdapter = new SimpleCursorAdapter(this, R.layout.item, null, FROM, TO, 0);

      // Associate the adapter with the ListView
      setListAdapter(mAdapter);

      // Initialize the loader
      LoaderManager lm = getLoaderManager();
      lm.initLoader(LOADER_ID, null, this);

      addEvent("Hello, Android!");
   }

   private void addEvent(String string) {
      // Insert a new record into the Events data source.
      // You would do something similar for delete and update.
      ContentValues values = new ContentValues();
      values.put(TIME, System.currentTimeMillis());
      values.put(TITLE, string);
      getContentResolver().insert(CONTENT_URI, values);
   }

   @Override
   public Loader<Cursor> onCreateLoader(int id, Bundle args) {
      // Create a new CursorLoader
      return new CursorLoader(this, CONTENT_URI, FROM, null, null, ORDER_BY);
   }

   @Override
   public void onLoadFinished(Loader<Cursor> loader, Cursor cursor) {
      switch (loader.getId()) {
         case LOADER_ID:
            // The data is now available to use
            mAdapter.swapCursor(cursor);
            break;
      }
   }

   @Override
   public void onLoaderReset(Loader<Cursor> loader) {
      // The loader's data is unavailable
      mAdapter.swapCursor(null);
   }
}
