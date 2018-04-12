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

    [Test] public void TestInputDecimal() {
      model.Input("3");
      model.Input(".");
      model.Input("1");
      model.Input("4");
      Assert.AreEqual("3.14", model.Display);
    }

  }
}

