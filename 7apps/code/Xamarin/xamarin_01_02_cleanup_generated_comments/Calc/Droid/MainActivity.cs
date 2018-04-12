/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;

using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;

namespace Calc.Droid {
  
  [Activity(Label = "Calc.Droid", MainLauncher = true, Icon = "@drawable/icon")]
  public class MainActivity : Activity {
    int count = 1;

    protected override void OnCreate(Bundle bundle) {
      base.OnCreate(bundle);
      SetContentView(Resource.Layout.Main);
      Button button = FindViewById<Button>(Resource.Id.myButton);
			
      button.Click += delegate {
        button.Text = string.Format("{0} clicks!", count++);
      };
    }
  }
}
