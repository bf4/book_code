/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package app.notoriety.models;

import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.SortedMap;
import java.util.concurrent.ConcurrentSkipListMap;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import app.notoriety.helpers.Log;
import app.notoriety.providers.NotesProvider;

public class NoteList
  implements Iterable<Note>
{
  private Context    mContext;

  public NoteList( Context context ) {
    mContext = context;
  }

  @Override
  public Iterator<Note> iterator() {
    return allNotes().values().iterator();
  }

  public Note get( String id ) {
    Uri uri = Uri.parse( NotesProvider.URL + "/" + id );
    Cursor c = mContext.getContentResolver()
        .query(uri, null, null, null, "createdAt");
    try {
      if( c.moveToFirst() ) {
        return cursorToNote( c );
      }
    } finally {
      c.close();
    }
    return null;
  }

  public void clearAll() {
    Cursor c = mContext.getContentResolver()
        .query(NotesProvider.CONTENT_URI, null, null, null, "createdAt");
    try {
      if( c.moveToFirst() ) {
         do {
           String id = c.getString(c.getColumnIndex( "id" ));
           Uri uri = Uri.parse( NotesProvider.URL + "/" + id );
           mContext.getContentResolver().delete(uri, null, null);
         } while( c.moveToNext() );
      }
    } finally {
      c.close();
    }
  }

  public SortedMap<String, Note> allNotes() {
    SortedMap<String, Note> notesMap =
        new ConcurrentSkipListMap<String, Note>(new Comparator<String>() {
          @Override
          public int compare(String lhs, String rhs) {
            Note lhn = get(lhs);
            Note rhn = get(rhs);
            if( lhn == null || lhn.getCreatedAt() == null ) return Integer.MIN_VALUE;
            if( rhn == null || rhn.getCreatedAt() == null ) return Integer.MAX_VALUE;
            return lhn.getCreatedAt().compareTo(rhn.getCreatedAt());
          }
        });
    Cursor c = mContext.getContentResolver()
        .query(NotesProvider.CONTENT_URI, null, null, null, "createdAt");
    try {
      if( c.moveToFirst() ) {
         do {
           Note note = cursorToNote(c);
           notesMap.put( note.getId(), note );
           // Log.d( "reloadNotes, note size " + mNotes.size() );
         } while( c.moveToNext() );
      }
    } finally {
      c.close();
    }
    return notesMap;
  }

  public void addNote( Note note ) {
    Uri newNote = mContext.getContentResolver()
        .insert(NotesProvider.CONTENT_URI, noteToContentValue(note));
    List<String> segments = newNote.getPathSegments();
    String noteId = segments.get(1);
    note.setId( noteId );
    Log.d("New note ID: %s", note.getId());
  }

  public void updateNote( String id, String body ) {
    Log.d("Update note ID: %s", id );
    Uri uri = Uri.parse( NotesProvider.URL + "/" + id );
    ContentValues noteVals = new ContentValues();
    noteVals.put( "body", body );
    mContext.getContentResolver().update(uri, noteVals, null, null);
  }

  public void deleteNote( String id ) {
    Log.d("Delete note ID: %s", id );
    Uri uri = Uri.parse( NotesProvider.URL + "/" + id );
    mContext.getContentResolver().delete(uri, null, null);
  }

  /**
   * Convert the values of the current cursor state to a Note object
   * @param c
   * @return
   */
  private Note cursorToNote( Cursor c ) {
    return new Note()
      .setId(c.getString(c.getColumnIndex( "id" )))
      .setBody(c.getString(c.getColumnIndex( "body" )))
      .setCreatedAt(new Date(c.getLong(c.getColumnIndex( "createdAt" ))))
      .setLatitude(c.getDouble(c.getColumnIndex( "latitude" )))
      .setLongitude(c.getDouble(c.getColumnIndex( "longitude" )));
  }

  /**
   * Extract the values in the current note to a Note object
   * @param note
   * @return
   */
  private ContentValues noteToContentValue( Note note ) {
    ContentValues noteVals = new ContentValues();
    noteVals.put( "body", note.getBody() );
    noteVals.put( "createdAt", note.getCreatedAt().getTime() );
    noteVals.put( "latitude", note.getLatitude() );
    noteVals.put( "longitude", note.getLongitude() );
    return noteVals;
  }
}