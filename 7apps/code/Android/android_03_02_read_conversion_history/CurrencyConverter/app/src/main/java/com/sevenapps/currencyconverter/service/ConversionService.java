/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter.service;

import android.app.IntentService;
import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;

import com.sevenapps.currencyconverter.api.ConversionAPI;
import com.sevenapps.currencyconverter.data.DatabaseHelper;
import com.sevenapps.currencyconverter.model.ConversionRate;
import com.sevenapps.currencyconverter.model.ConversionRateHistoryRecord;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

import java.io.IOException;

import retrofit.RestAdapter;

public class ConversionService extends IntentService {

  public static final String CONVERSION_RESULT_ACTION = "CONVERSION_RESULT_ACTION";
  public static final String CONVERSION_RESULT_EXTRA = "CONVERSION_RESULT_EXTRA";
  public static final String AMOUNT = "amount";
  public static final String FROM = "from";
  public static final String TO = "to";

  private static final String LOG_TAG = "[Conversion Service]";

  public ConversionService() {
    super("Conversion Service");
  }

  @Override protected void onHandleIntent(Intent intent) {
    String fromCurrency = intent.getStringExtra(FROM);
    String toCurrency = intent.getStringExtra(TO);
    String amount = intent.getStringExtra(AMOUNT);
    // Use this for emulator String url = "http://10.0.2.2:3000";
    // Use this for genymotion String url = "http://10.0.3.2:3000";
    RestAdapter adapter = new RestAdapter.Builder()
        .setEndpoint("http://10.0.3.2:3000/")
        .build();
    ConversionAPI api = adapter.create(ConversionAPI.class);
    ConversionRate rate = api.convert(fromCurrency, toCurrency);

    DatabaseHelper databaseHelper = new DatabaseHelper(this);
    ConversionRateHistoryRecord record = ConversionRateHistoryRecord.fromRate(rate, amount);
    databaseHelper.insertHistoryRecord(record);

    LocalBroadcastManager broadcastManager = LocalBroadcastManager.getInstance(this);
    Intent conversionResultIntent = new Intent(CONVERSION_RESULT_ACTION);
    conversionResultIntent.putExtra(CONVERSION_RESULT_EXTRA, rate);
    broadcastManager.sendBroadcast(conversionResultIntent);
  }
}
