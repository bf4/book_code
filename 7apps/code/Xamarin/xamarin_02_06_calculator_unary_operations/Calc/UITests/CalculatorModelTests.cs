/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;
using NUnit.Framework;

namespace Calc.UITests {
  
  [TestFixture]
  public class CalculatorModelTests {

    CalculatorModel model;

    [SetUp]
    public void SetUp() {
      model = new CalculatorModel();
    }

    [Test] public void TestDefaultDisplay() {
      Assert.AreEqual("0", model.Display);
    }

    [Test] public void TestInputNumber() {
      model.Input("4");
      model.Input("2");
      Assert.AreEqual("42", model.Display);
    }

    [Test] public void TestClear() {
      model.Input("5");
      model.Input("C");
      Assert.AreEqual("0", model.Display);
    }

    [Test] public void TestInputDecimal() {
      model.Input("3");
      model.Input(".");
      model.Input("1");
      model.Input("4");
      Assert.AreEqual("3.14", model.Display);
    }

    [Test] public void TestInputMoreDecimals() {
      model.Input("3");
      model.Input(".");
      model.Input("1");
      model.Input(".");
      model.Input("4");
      model.Input(".");
      Assert.AreEqual("3.14", model.Display);
    }

    [Test] public void TestInputDecimalFirst() {
      model.Input(".");
      Assert.AreEqual("0.", model.Display);
      model.Input("1");
      model.Input(".");
      Assert.AreEqual("0.1", model.Display);
    }

    [Test] public void TestInputLotsOfZeroes() {
      model.Input("0");
      model.Input("0");
      Assert.AreEqual("0", model.Display);
      model.Input("1");
      model.Input("0");
      Assert.AreEqual("10", model.Display);
      model.Input(".");
      model.Input("0");
      model.Input("1");
      Assert.AreEqual("10.01", model.Display);
    }

    [Test] public void TestToggleNegation() {
      model.Input("+/-");
      Assert.AreEqual("0", model.Display);
      model.Input("1");
      model.Input("+/-");
      Assert.AreEqual("-1", model.Display);
      model.Input("+/-");
      Assert.AreEqual("1", model.Display);
    }

    [Test] public void TestPercent() {
      model.Input("%");
      Assert.AreEqual("0", model.Display);
      model.Input("8");
      model.Input("%");
      Assert.AreEqual("0.08", model.Display);
      model.Input("%");
      Assert.AreEqual("0.0008", model.Display);
    }

    [Test] public void TestPostPercentFormatting() {
      model.Input("100");
      model.Input("%");
      Assert.AreEqual("1", model.Display);
      model.Input("C");
      model.Input("101");
      model.Input("%");
      Assert.AreEqual("1.01", model.Display);
    }

  }
}

