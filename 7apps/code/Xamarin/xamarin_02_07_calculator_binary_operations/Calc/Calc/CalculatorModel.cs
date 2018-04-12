/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;
using System.Collections.Generic;
using System.Linq;

namespace Calc {
  public class CalculatorModel {

    public static string[] buttons = {
      "C", "+/-", "%", "÷",
      "7", "8", "9", "×",
      "4", "5", "6", "-",
      "1", "2", "3", "+",
      "0", ".", "="
    };

    private Value currentValue;
    private Stack<Value> valueStack;
    private Stack<Operator> operatorStack;

    public CalculatorModel() {
      valueStack = new Stack<Value>();
      operatorStack = new Stack<Operator>();
    }

    public string Display {
      get {
        if (valueStack.Count == 0) {
          return "0";
        } else {
          return valueStack.Peek().ToString();
        }
      }
    }

    public void Input(string s) {
      if (s.Equals("C")) {
        Clear();
      } else if (s.Equals("=")) {
        CompleteCalculation();
        currentValue = null;
      } else {
        if (Operator.StringIsOperator(s)) {
          currentValue = null;
          PushOperator(new Operator(s));
        } else {
          ApplyToCurrentValue(s);
        }
      }
    }

    void ApplyToCurrentValue(string s) {
      if (currentValue == null) {
        currentValue = new Value();
        valueStack.Push(currentValue);
      }
      currentValue.apply(s);
    }

    void PushOperator(Operator op) {
      if (operatorStack.Count > 0) {
        var lastOperator = operatorStack.Peek();
        if (lastOperator.HasHigherPrecidenceThan(op)) {
          PopOperatorAndCalculate();
        }
      }
      operatorStack.Push(op);
    }

    void PopOperatorAndCalculate() {
      if (operatorStack.Count > 0 && valueStack.Count > 1) {
        var op = operatorStack.Pop();
        var right = valueStack.Pop();
        var left = valueStack.Pop();
        var result = op.Operate(left, right);
        var value = new Value();
        value.apply(result.ToString());
        valueStack.Push(value);
      }
    }

    void CompleteCalculation() {
      if (operatorStack.Count > 0 && valueStack.Count > 1) {
        while (operatorStack.Count > 0) {
          PopOperatorAndCalculate();
        }
      }
    }

    void Clear() {
      currentValue = null;
      valueStack.Clear();
      operatorStack.Clear();
    }

  }

  class Operator {
    public static bool StringIsOperator(string s) {
      return (
        s.Equals("+") || s.Equals("-") || s.Equals("÷") || s.Equals("×")
      );
    }

    public string Type { get; private set; }

    public Operator(string type) {
      this.Type = type;
    }

    public bool HasHigherPrecidenceThan(Operator other) {
      return (Type.Equals("×") || Type.Equals("÷")) &&
        (other.Type.Equals("+") || other.Type.Equals("-"));
    }

    public float Operate(Value leftValue, Value rightValue) {
      float left = leftValue.ToFloat;
      float right = rightValue.ToFloat;
      if (Type.Equals("+")) {
        return left + right;
      } else if (Type.Equals("-")) {
        return left - right;
      } else if (Type.Equals("×")) {
        return left * right;
      } else {
        return left / right;
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
      if (
        (s.Equals("0") ||
        isPlusMinus ||
        isPercent)
        && value == null) {
        return;
      };

      if (isPlusMinus) {
        ToggleNegative();
      } else if (isPercent) {
        ConvertToPercent();
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
      var f = ToFloat / 100;
      value = Convert.ToString(f);
    }

    void ToggleNegative() {
      if (isNegative) {
        value = value.TrimStart('-');
        isNegative = false;
      }
      else {
        value = "-" + value;
        isNegative = true;
      }
    }

    public float ToFloat {
      get {
        return float.Parse(value);
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

