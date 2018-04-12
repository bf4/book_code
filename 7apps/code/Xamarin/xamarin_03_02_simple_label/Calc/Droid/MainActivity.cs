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
using Android.Support.V7.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;
using Android.Support.V7.Widget;

namespace Calc.Droid {
  [Activity (Label = "Calc", MainLauncher = true, Icon = "@drawable/icon")]
  public class MainActivity : AppCompatActivity	{

    protected override void OnCreate(Bundle bundle) {
      base.OnCreate (bundle);

      SetContentView(Resource.Layout.Main);
		}

	}
}


