/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;

using Xamarin.Forms;

namespace CalcForms {
  public class App : Application {
    public App() {
      var calculatorPage = new ContentPage {
        Title = "Calc",
        Content = new StackLayout {
          Children = {
            new Label {
              XAlign = TextAlignment.End,
              Text = "0",
              BackgroundColor = Color.Gray,
              FontSize = 48.0,
            }
          }
        }
      };
      Device.OnPlatform(iOS: () => {
        calculatorPage.Padding = new Thickness(0, 20, 0, 0);
      });
      MainPage = calculatorPage;
    }
  }
}

