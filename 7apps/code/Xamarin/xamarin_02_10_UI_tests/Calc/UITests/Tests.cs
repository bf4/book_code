/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;
using System.IO;
using System.Linq;
using NUnit.Framework;
using Xamarin.UITest;
using Xamarin.UITest.Queries;

namespace Calc.UITests {
  
  [TestFixture(Platform.Android)]
  [TestFixture(Platform.iOS)]
  public class Tests {
    IApp app;
    Platform platform;

    public Tests(Platform platform) {
      this.platform = platform;
    }

    [SetUp] public void BeforeEachTest() {
      app = AppInitializer.StartApp(platform);
    }

    [Test] public void OnePlusTwoShouldEqualThree() {
      Func<AppQuery, AppQuery> oneButton = q => q.Text("1");
      Func<AppQuery, AppQuery> twoButton = q => q.Text("2");
      Func<AppQuery, AppQuery> plusButton = q => q.Text("+");
      Func<AppQuery, AppQuery> equalsButton = q => q.Text("=");
      Func<AppQuery, AppQuery> display = q => q.Id("calculator_display");

      app.Tap(oneButton);
      app.Tap(plusButton);
      app.Tap(twoButton);
      app.Tap(equalsButton);
      AppResult[] results = app.Query(display);

      Assert.AreEqual("3", results[0].Text ?? results[0].Label);
    }
  }
}

