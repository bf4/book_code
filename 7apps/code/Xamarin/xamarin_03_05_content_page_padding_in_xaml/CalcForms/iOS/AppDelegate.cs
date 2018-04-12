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

using Foundation;
using UIKit;

namespace CalcForms.iOS {
  [Register("AppDelegate")]
  public partial class AppDelegate : global::Xamarin.Forms.Platform.iOS.FormsApplicationDelegate {
    public override bool FinishedLaunching(UIApplication app, NSDictionary options) {
      global::Xamarin.Forms.Forms.Init();

      // Code for starting up the Xamarin Test Cloud Agent
      #if ENABLE_TEST_CLOUD
			Xamarin.Calabash.Start();
      #endif

      LoadApplication(new App());

      return base.FinishedLaunching(app, options);
    }
  }
}

