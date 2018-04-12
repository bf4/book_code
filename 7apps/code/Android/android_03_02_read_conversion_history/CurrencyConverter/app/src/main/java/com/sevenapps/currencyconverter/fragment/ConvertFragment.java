/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter.fragment;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import com.sevenapps.currencyconverter.R;
import com.sevenapps.currencyconverter.model.ConversionRate;
import com.sevenapps.currencyconverter.service.ConversionService;

public class ConvertFragment extends Fragment {

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

  @Override public View onCreateView(
      LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
    return inflater.inflate(R.layout.conversion_form, container, false);
  }

  @Override public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    IntentFilter intentFilter = new IntentFilter(ConversionService.CONVERSION_RESULT_ACTION);
    LocalBroadcastManager.getInstance(getActivity()).registerReceiver(conversionReceiver, intentFilter);

    if (savedInstanceState != null) {
      currentRate = (ConversionRate) savedInstanceState.getSerializable(CURRENT_RATE);
    }
  }

  @Override public void onDestroy() {
    LocalBroadcastManager.getInstance(getActivity()).unregisterReceiver(conversionReceiver);
    super.onDestroy();
  }

  @Override public void onStart() {
    super.onStart();
    fromCurrencyField = (EditText) getView().findViewById(R.id.from_currency);
    toCurrencyField = (EditText) getView().findViewById(R.id.to_currency);
    fromAmountField = (EditText) getView().findViewById(R.id.from_amount);
    toAmountField = (EditText) getView().findViewById(R.id.to_amount);
    convertButton = (Button) getView().findViewById(R.id.convert_button);
    convertButton.setOnClickListener(new View.OnClickListener() {
      @Override public void onClick(View v) {
        convert();
      }
    });
  }

  private void convert() {
    String from = fromCurrencyField.getText().toString();
    String to = toCurrencyField.getText().toString();
    String amount = fromAmountField.getText().toString();
    if (from != null && to != null && from.length() == 3 && to.length() == 3) {
      getRate(from, to, amount);
    }
  }

  private void getRate(String from, String to, String amount) {
    Intent convertIntent = new Intent(getActivity(), ConversionService.class);
    convertIntent.putExtra(ConversionService.FROM, from);
    convertIntent.putExtra(ConversionService.TO, to);
    convertIntent.putExtra(ConversionService.AMOUNT, amount);
    getActivity().startService(convertIntent);
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

}
