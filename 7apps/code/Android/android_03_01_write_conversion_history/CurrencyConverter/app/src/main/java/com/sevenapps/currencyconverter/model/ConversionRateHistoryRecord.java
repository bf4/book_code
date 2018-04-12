/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter.model;

import android.content.ContentValues;
import android.database.Cursor;
import android.provider.BaseColumns;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class ConversionRateHistoryRecord implements Serializable {

  public static final class ConversionHistoryContract {

    public ConversionHistoryContract() { }

    public static abstract class ConversionHistoryRecord implements BaseColumns {
      public static final String TABLE_NAME             = "conversion_history_records";
      public static final String FROM_CURRENCY_COLUMN   = "from_currency";
      public static final String TO_CURRENCY_COLUMN     = "to_currency";
      public static final String RATE_COLUMN            = "rate";
      public static final String AMOUNT_COLUMN          = "amount";
      public static final String TIMESTAMP_COLUMN       = "timestamp";
    }

    public static String createStatement() {
      return "create table " + ConversionHistoryRecord.TABLE_NAME + " (" +
          ConversionHistoryRecord._ID                   + " integer primary key," +
          ConversionHistoryRecord.FROM_CURRENCY_COLUMN  + " text," +
          ConversionHistoryRecord.TO_CURRENCY_COLUMN    + " text, " +
          ConversionHistoryRecord.RATE_COLUMN           + " real, " +
          ConversionHistoryRecord.AMOUNT_COLUMN         + " real, " +
          ConversionHistoryRecord.TIMESTAMP_COLUMN      +
                               " datetime default current_timestamp)";
    }

  }

  public long id;
  public String fromCurrency;
  public String toCurrency;
  public float rate;
  public float amount;
  public Date date;

  public ContentValues toContentValues() {
    ContentValues values = new ContentValues();
    values.put(ConversionHistoryContract.ConversionHistoryRecord.
      FROM_CURRENCY_COLUMN, fromCurrency);
    values.put(ConversionHistoryContract.ConversionHistoryRecord.
      TO_CURRENCY_COLUMN, toCurrency);
    values.put(ConversionHistoryContract.ConversionHistoryRecord.
      RATE_COLUMN, rate);
    values.put(ConversionHistoryContract.ConversionHistoryRecord.
      AMOUNT_COLUMN, amount);
    return values;
  }

  public static ConversionRateHistoryRecord fromRate(ConversionRate rate, String amount) {
    ConversionRateHistoryRecord record = new ConversionRateHistoryRecord();
    record.fromCurrency = rate.from;
    record.toCurrency = rate.to;
    record.rate = rate.rate;
    try {
      Float floatAmount = Float.parseFloat(amount);
      record.amount = floatAmount;
    } catch (NumberFormatException e) {
      record.amount = 1f;
    }

    return record;
  }

  public static ArrayList<ConversionRateHistoryRecord> allFromCursor(Cursor cursor) {
    int count = cursor.getColumnCount();
    ArrayList<ConversionRateHistoryRecord> list = new ArrayList<>(count);
    while (cursor.moveToNext()) {
      list.add(ConversionRateHistoryRecord.oneFromCursor(cursor));
    }
    return list;
  }

  private static ConversionRateHistoryRecord oneFromCursor(Cursor cursor) {
    ConversionRateHistoryRecord record = new ConversionRateHistoryRecord();
    record.id = cursor.getLong(cursor.getColumnIndex(ConversionHistoryContract.ConversionHistoryRecord._ID));
    record.fromCurrency = cursor.getString(cursor.getColumnIndex(ConversionHistoryContract.ConversionHistoryRecord.FROM_CURRENCY_COLUMN));
    record.toCurrency = cursor.getString(cursor.getColumnIndex(ConversionHistoryContract.ConversionHistoryRecord.TO_CURRENCY_COLUMN));
    record.rate = cursor.getFloat(cursor.getColumnIndex(ConversionHistoryContract.ConversionHistoryRecord.RATE_COLUMN));
    record.amount = cursor.getFloat(cursor.getColumnIndex(ConversionHistoryContract.ConversionHistoryRecord.AMOUNT_COLUMN));
    return record;
  }

}
