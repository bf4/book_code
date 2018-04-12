/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using Stocks.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Core;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Media.Animation;
using Windows.UI.Xaml.Navigation;

namespace Stocks.Pages {
  public sealed partial class StockQuoteDetailView : Page {

    public StockQuote Quote { get; set; }

    public StockQuoteDetailView() {
      this.InitializeComponent();
    }

    protected override void OnNavigatedTo(NavigationEventArgs e) {
      base.OnNavigatedTo(e);
      var quote = (StockQuote)e.Parameter;
      Quote = quote;
      SystemNavigationManager systemNavigationManager =
        SystemNavigationManager.GetForCurrentView();
      systemNavigationManager.BackRequested += BackRequested;
      systemNavigationManager.AppViewBackButtonVisibility =
        AppViewBackButtonVisibility.Visible;
    }

    protected override void OnNavigatedFrom(NavigationEventArgs e) {
      base.OnNavigatedFrom(e);

      SystemNavigationManager systemNavigationManager =
        SystemNavigationManager.GetForCurrentView();
      systemNavigationManager.BackRequested -= BackRequested;
      systemNavigationManager.AppViewBackButtonVisibility =
        AppViewBackButtonVisibility.Collapsed;
    }

    private void BackRequested(object sender, BackRequestedEventArgs e) {
      e.Handled = true;
      OnBackRequested();
    }

    private void OnBackRequested() {
      Frame.GoBack(new DrillInNavigationTransitionInfo());
    }

  }
}
