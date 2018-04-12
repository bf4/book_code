/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter.data;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sevenapps.currencyconverter.model.ConversionRateHistoryRecord;

import com.sevenapps.currencyconverter.model.ConversionRateHistoryRecord.*;

import java.util.ArrayList;

public class DatabaseHelper extends SQLiteOpenHelper {

  public static final int VERSION = 1;
  public static final String DATABASE_NAME = "conversion_database.db";

  public DatabaseHelper(Context context) {
    super(context, DATABASE_NAME, null, VERSION);
  }

  @Override public void onCreate(SQLiteDatabase db) {
    db.execSQL(ConversionHistoryContract.createStatement());
  }

  @Override public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
    // No action this version
  }

  public void insertHistoryRecord(ConversionRateHistoryRecord record) {
    SQLiteDatabase database = getWritableDatabase();
    ContentValues values = record.toContentValues();
    database.insert(
      ConversionHistoryContract.ConversionHistoryRecord.TABLE_NAME,
      null,
      values
    );
  }

  public ArrayList<ConversionRateHistoryRecord> getAllHistoryRecords() {
    SQLiteDatabase database = getReadableDatabase();
    String[] projection = new String[] {
        ConversionHistoryContract.ConversionHistoryRecord._ID,
        ConversionHistoryContract.ConversionHistoryRecord.FROM_CURRENCY_COLUMN,
        ConversionHistoryContract.ConversionHistoryRecord.TO_CURRENCY_COLUMN,
        ConversionHistoryContract.ConversionHistoryRecord.RATE_COLUMN,
        ConversionHistoryContract.ConversionHistoryRecord.AMOUNT_COLUMN,
        ConversionHistoryContract.ConversionHistoryRecord.TIMESTAMP_COLUMN
    };
    String sortBy = ConversionHistoryContract.ConversionHistoryRecord.TIMESTAMP_COLUMN + " desc";
    Cursor cursor = database.query(
        ConversionHistoryContract.ConversionHistoryRecord.TABLE_NAME,
        projection,
        null,
        null,
        null,
        null,
        sortBy
    );
    return ConversionRateHistoryRecord.allFromCursor(cursor);
  }

}
