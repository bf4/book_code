/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter.api;

import com.sevenapps.currencyconverter.model.ConversionRate;

import retrofit.http.GET;
import retrofit.http.Path;

public interface ConversionAPI {

  @GET("/convert/{fromCurrency}/{toCurrency}.json")
  public ConversionRate convert(
    @Path("fromCurrency") String fromCurrency,
    @Path("toCurrency") String toCurrency);

}
