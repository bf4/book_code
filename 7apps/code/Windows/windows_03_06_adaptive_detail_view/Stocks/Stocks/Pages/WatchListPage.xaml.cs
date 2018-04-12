/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using Stocks.Data;
using Stocks.Models;
using Stocks.ViewComponents;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Threading.Tasks;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

namespace Stocks.Pages {
  public sealed partial class WatchListPage : UserControl {

    public event EventHandler<StockQuoteSelectedEventArgs> StockQuoteSelected;

    public WatchListPage() {
      this.InitializeComponent();
    }

    private void AddSymbolButton_Click(object sender, RoutedEventArgs e) {
      string symbol = AddSymbolTextBox.Text;
      LoadAndDisplaySymbol(symbol);
    }

    private void LoadAndDisplaySymbol(string symbol) {
      model.AddWatchedSymbol(symbol);
    }

    private void StockQuoteList_StockQuoteSelected(object sender, StockQuoteSelectedEventArgs e) {
      if (StockQuoteSelected != null) {
        StockQuoteSelected(this, new StockQuoteSelectedEventArgs(e.Quote));
      }
    }
  }
}
