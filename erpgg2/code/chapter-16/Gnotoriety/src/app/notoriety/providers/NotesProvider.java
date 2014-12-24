/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package app.notoriety.providers;

import static android.text.TextUtils.isEmpty;

import java.util.HashMap;

import android.content.ContentProvider;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.content.UriMatcher;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteQueryBuilder;
import android.net.Uri;

/**
 * 
 * @author ericredmond
 * @author http://www.tutorialspoint.com/android/android_content_providers.htm
 */
public class NotesProvider
  extends ContentProvider
{
  public static final String PROVIDER_NAME = "app.notoriety.providers";
  public static final String URL = "content://" + PROVIDER_NAME + "/notes";
  public static final Uri    CONTENT_URI = Uri.parse(URL);
  static final int NOTES    = 1;
  static final int NOTES_ID = 2;
  static final UriMatcher uriMatcher;
  static {
    uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
    uriMatcher.addURI(PROVIDER_NAME, "notes", NOTES);
    uriMatcher.addURI(PROVIDER_NAME, "notes/#", NOTES_ID);
  }
  static final String  DATABASE_NAME    = "Notoriety";
  static final String  NOTES_TABLE_NAME = "notes";
  static final int     DATABASE_VERSION = 1;
  static final String  CREATE_DB_TABLE  =
      " CREATE TABLE "
      + NOTES_TABLE_NAME
      + " (id INTEGER PRIMARY KEY AUTOINCREMENT, "
      + " body TEXT NOT NULL, "
      + " latitude DOUBLE NOT NULL, "
      + " longitude DOUBLE NOT NULL, "
      + " createdAt DATETIME NOT NULL);";
  
  private static HashMap<String, String> NOTES_PROJECTION_MAP;
  private SQLiteDatabase  db;

  /**
   * Helper class that actually creates and manages the provider's underlying
   * data repository.
   */
  private static class DatabaseHelper
    extends SQLiteOpenHelper
  {
    DatabaseHelper(Context context) {
      super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
      db.execSQL(CREATE_DB_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
      db.execSQL("DROP TABLE IF EXISTS " + NOTES_TABLE_NAME);
      onCreate(db);
    }
  }

  @Override
  public boolean onCreate() {
    Context context = getContext();
    DatabaseHelper dbHelper = new DatabaseHelper(context);
    // Create a write able database which will trigger its creation if
    // it doesn't already exist
    db = dbHelper.getWritableDatabase();
    return db != null;
  }

  @Override
  public Uri insert( Uri uri, ContentValues values ) {
    // Add a new note
    long rowID = db.insert(NOTES_TABLE_NAME, "", values);
    // If record is added successfully
    if( rowID > 0 ) {
      Uri newUri = ContentUris.withAppendedId( CONTENT_URI, rowID );
      getContext().getContentResolver().notifyChange(newUri, null);
      return newUri;
    }
    throw new SQLException("Failed to add a new note into " + uri);
  }
  
  @Override
  public Cursor query(Uri uri, String[] projection, String selection,
                      String[] selectionArgs, String sortOrder)
  {
    SQLiteQueryBuilder qb = new SQLiteQueryBuilder();
    qb.setTables( NOTES_TABLE_NAME );
    switch( uriMatcher.match(uri) ) {
    case NOTES:
      qb.setProjectionMap(NOTES_PROJECTION_MAP);
      break;
    case NOTES_ID:
      qb.appendWhere("id =" + uri.getPathSegments().get(1));
      break;
    default:
      throw new IllegalArgumentException("Unknown URI " + uri);
    }
    if (sortOrder == null || sortOrder == "") {
      // By default sort by createdAt date
      sortOrder = "createdAt";
    }
    Cursor c = qb.query(db, projection, selection, selectionArgs, null, null, sortOrder);
    // register to watch a content URI for changes
    c.setNotificationUri(getContext().getContentResolver(), uri);
    return c;
  }

  @Override
  public int delete(Uri uri, String selection, String[] selectionArgs) {
    int count = 0;
    switch (uriMatcher.match(uri)) {
    case NOTES:
      count = db.delete(NOTES_TABLE_NAME, selection, selectionArgs);
      break;
    case NOTES_ID:
      String id = uri.getPathSegments().get(1);
      String where = "id = " + id;
      if( !isEmpty(selection) ) {
        where += String.format(" AND (%s)", selection);
      }
      count = db.delete(NOTES_TABLE_NAME, where, selectionArgs);
      break;
    default:
      throw new IllegalArgumentException("Unknown URI " + uri);
    }
    getContext().getContentResolver().notifyChange(uri, null);
    return count;
  }

  @Override
  public int update(Uri uri, ContentValues values,
                    String selection, String[] selectionArgs)
  {
    int count = 0;
    switch (uriMatcher.match(uri)) {
    case NOTES:
      count = db.update(NOTES_TABLE_NAME, values, selection, selectionArgs);
      break;
    case NOTES_ID:
      String id = uri.getPathSegments().get(1);
      String where = "id = " + id;
      if( !isEmpty(selection) ) {
        where += String.format(" AND (%s)", selection);
      }
      count = db.update(NOTES_TABLE_NAME, values, where, selectionArgs);
      break;
    default:
      throw new IllegalArgumentException("Unknown URI " + uri);
    }
    getContext().getContentResolver().notifyChange(uri, null);
    return count;
  }

  @Override
  public String getType(Uri uri) {
    switch( uriMatcher.match(uri) ) {
    case NOTES:
      return "vnd.android.cursor.dir/vnd.example.notes";
    case NOTES_ID:
      return "vnd.android.cursor.item/vnd.example.notes";
    default:
      throw new IllegalArgumentException("Unsupported URI: " + uri);
    }
  }
}