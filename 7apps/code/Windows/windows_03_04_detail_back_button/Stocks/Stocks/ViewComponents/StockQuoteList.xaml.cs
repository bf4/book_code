/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;
using Stocks.Models;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Media.Animation;
using Windows.UI.Xaml.Navigation;

namespace Stocks.ViewComponents {
  public sealed partial class StockQuoteList : UserControl {

    public event EventHandler<StockQuoteSelectedEventArgs> StockQuoteSelected;

    public StockQuoteList() {
      this.InitializeComponent();
    }

    private void StockQuote_ItemClick(object sender, ItemClickEventArgs e) {
      var quote = (StockQuote)e.ClickedItem;
      if (StockQuoteSelected != null) {
        StockQuoteSelected(this, new StockQuoteSelectedEventArgs(quote));
      }
    }
  }
}
