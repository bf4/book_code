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
      // The root page of your application
      MainPage = new ContentPage {
        Content = new StackLayout {
          VerticalOptions = LayoutOptions.Center,
          Children = {
            new Label {
              XAlign = TextAlignment.Center,
              Text = "Welcome to Xamarin Forms!"
            }
          }
        }
      };
    }

    protected override void OnStart() {
      // Handle when your app starts
    }

    protected override void OnSleep() {
      // Handle when your app sleeps
    }

    protected override void OnResume() {
      // Handle when your app resumes
    }
  }
}

