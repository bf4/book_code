/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;

namespace Calc {
  public class CalculatorModel {

    private Value currentValue;

    public string Display {
      get {
        if (currentValue == null) {
          return "0";
        } else {
          return currentValue.ToString();
        }
      }
    }

    public void Input(string expression) {
      if (expression.Equals("C")) {
        currentValue = null;
      } else {
        if (currentValue == null) {
          currentValue = new Value();
        }
        currentValue.apply(expression);
      }
    }

  }

  class Value {
    string value;
    public bool isFloat;
    public bool isNegative;

    public void apply(string s) {
      var isPlusMinus = s.Equals("+/-");
      var isPercent = s.Equals("%");
      if ((s.Equals("0") || isPlusMinus || isPercent)
          && value == null) {
        return;
      }
      ;

      if (isPlusMinus) {
        ToggleNegative();
      } else if (isPercent) {
        ConvertToPercent();
        return;
      } else {
        append(s);
      }
    }

    void append(string s) {
      var isDecimal = s.Equals(".");
      if (isDecimal && isFloat) {
        return;
      } else {
        if (isDecimal && value == null) {
          value = "0";
        }
        value += s;
      }

      isFloat = isFloat || isDecimal;
    }

    void ConvertToPercent() {
      var f = float.Parse(value) / 100;
      value = Convert.ToString(f);
    }

    void ToggleNegative() {
      if (isNegative) {
        value = value.TrimStart('-');
        isNegative = false;
      } else {
        value = "-" + value;
        isNegative = true;
      }
    }

    public override string ToString() {
      if (value == null) {
        return "0";
      }
      return value;
    }
  }
}

