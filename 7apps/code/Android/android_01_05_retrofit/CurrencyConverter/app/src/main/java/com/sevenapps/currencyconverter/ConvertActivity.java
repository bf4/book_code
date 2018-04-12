/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.support.v4.content.LocalBroadcastManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;

import com.sevenapps.currencyconverter.model.ConversionRate;
import com.sevenapps.currencyconverter.service.ConversionService;

public class ConvertActivity extends AppCompatActivity {

  private static final String LOG_TAG = "[Convert Activity]";

  private BroadcastReceiver conversionReceiver = new BroadcastReceiver() {
    @Override public void onReceive(Context context, Intent intent) {
      ConversionRate result = (ConversionRate) intent.getSerializableExtra(
        ConversionService.CONVERSION_RESULT_EXTRA);
      conversionComplete(result);
    }
  };

  @Override protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_convert);

    IntentFilter intentFilter = new IntentFilter(ConversionService.CONVERSION_RESULT_ACTION);
    LocalBroadcastManager.getInstance(this).registerReceiver(conversionReceiver, intentFilter);

    convertCurrency("USD", "EUR");
  }

  @Override protected void onDestroy() {
    LocalBroadcastManager.getInstance(this).unregisterReceiver(conversionReceiver);
    super.onDestroy();
  }

  private void convertCurrency(String from, String to) {
    Intent convertIntent = new Intent(this, ConversionService.class);
    convertIntent.putExtra(ConversionService.FROM, from);
    convertIntent.putExtra(ConversionService.TO, to);
    startService(convertIntent);
  }

  private void conversionComplete(ConversionRate payload) {
    Log.d(LOG_TAG, "Conversion response, payload: " + payload);
  }

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    // Inflate the menu; this adds items to the action bar if it is present.
    getMenuInflater().inflate(R.menu.menu_convert, menu);
    return true;
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    // Handle action bar item clicks here. The action bar will
    // automatically handle clicks on the Home/Up button, so long
    // as you specify a parent activity in AndroidManifest.xml.
    int id = item.getItemId();

    //noinspection SimplifiableIfStatement
    if (id == R.id.action_settings) {
      return true;
    }

    return super.onOptionsItemSelected(item);
  }
}
