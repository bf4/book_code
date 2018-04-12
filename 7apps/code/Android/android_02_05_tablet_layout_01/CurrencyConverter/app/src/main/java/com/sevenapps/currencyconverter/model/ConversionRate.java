/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
package com.sevenapps.currencyconverter.model;

import java.io.Serializable;

public class ConversionRate implements Serializable {

  public String name;
  public String from;
  public String to;
  public float rate;

  public Float convert(String amount) {
    try {
      Float floatAmount = Float.parseFloat(amount);
      return convert(floatAmount);
    } catch (NumberFormatException e) {
      return 0.0f;
    }
  }

  public Float convert(Float floatAmount) {
    Float convertedAmount = floatAmount * rate;
    return convertedAmount;
  }

  public Float inverse(String amount) {
    try {
      Float floatAmount = Float.parseFloat(amount);
      return inverse(floatAmount);
    } catch (NumberFormatException e) {
      return 0.0f;
    }
  }

  public Float inverse(Float floatAmount) {
    return 1 / convert(floatAmount);
  }

  @Override public String toString() {
    return "ConversionRate{" +
        "name='" + name + '\'' +
        ", from='" + from + '\'' +
        ", to='" + to + '\'' +
        ", rate=" + rate +
        '}';
  }
}
