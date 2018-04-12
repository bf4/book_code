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
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.sevenapps.currencyconverter.model.ConversionRate;
import com.sevenapps.currencyconverter.service.ConversionService;

public class ConvertActivity extends AppCompatActivity {

  private static final String LOG_TAG = "[Convert Activity]";
  private static final String CURRENT_RATE = "CURRENT_RATE";

  private EditText fromCurrencyField;
  private EditText toCurrencyField;
  private EditText fromAmountField;
  private EditText toAmountField;
  private Button convertButton;

  private ConversionRate currentRate;

  private BroadcastReceiver conversionReceiver = new BroadcastReceiver() {
    @Override public void onReceive(Context context, Intent intent) {
      ConversionRate result = (ConversionRate) intent.getSerializableExtra(
          ConversionService.CONVERSION_RESULT_EXTRA);
      rateLoaded(result);
    }
  };

  @Override protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_convert);

    IntentFilter intentFilter = new IntentFilter(ConversionService.CONVERSION_RESULT_ACTION);
    LocalBroadcastManager.getInstance(this).registerReceiver(conversionReceiver, intentFilter);

    fromCurrencyField = (EditText) findViewById(R.id.from_currency);
    toCurrencyField = (EditText) findViewById(R.id.to_currency);
    fromAmountField = (EditText) findViewById(R.id.from_amount);
    toAmountField = (EditText) findViewById(R.id.to_amount);
    convertButton = (Button) findViewById(R.id.convert_button);

    if (savedInstanceState != null) {
      currentRate = (ConversionRate) savedInstanceState.getSerializable(CURRENT_RATE);
    } else {
      fromAmountField.setText("1.00");
      toAmountField.setText("1.00");
    }

    convertButton.setOnClickListener(new View.OnClickListener() {
      @Override public void onClick(View v) {
        convert();
      }
    });
  }

  @Override protected void onDestroy() {
    LocalBroadcastManager.getInstance(this).unregisterReceiver(conversionReceiver);
    super.onDestroy();
  }

  @Override protected void onSaveInstanceState(Bundle outState) {
    super.onSaveInstanceState(outState);
    outState.putSerializable(CURRENT_RATE, currentRate);
  }

  private void convert() {
    if (currenciesChanged()) {
      getRate();
    } else {
      calculateToAmount();
    }
  }

  private boolean currenciesChanged() {
    if (currentRate != null) {
      String from = fromCurrencyField.getText().toString().toLowerCase();
      String to = toCurrencyField.getText().toString().toLowerCase();
      if (from.equals(currentRate.from.toLowerCase()) && to.equals(currentRate.to.toLowerCase())) {
        return false;
      }
    }
    return true;
  }

  private void getRate() {
    String from = fromCurrencyField.getText().toString();
    String to = toCurrencyField.getText().toString();
    if (from != null && to != null && from.length() == 3 && to.length() == 3) {
      getRate(from, to);
    }
  }

  private void getRate(String from, String to) {
    Intent convertIntent = new Intent(this, ConversionService.class);
    convertIntent.putExtra(ConversionService.FROM, from);
    convertIntent.putExtra(ConversionService.TO, to);
    startService(convertIntent);
  }

  private void rateLoaded(ConversionRate newRate) {
    currentRate = newRate;
    calculateToAmount();
  }

  private void calculateToAmount() {
    if (currentRate != null) {
      Float toAmount = currentRate.convert(fromAmountField.getText().toString());
      String formattedToAmount = String.format("%.2f", toAmount);
      toAmountField.setText(formattedToAmount);
    }
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
