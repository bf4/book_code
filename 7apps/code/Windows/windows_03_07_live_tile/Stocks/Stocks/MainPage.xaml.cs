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
using Stocks.Pages;
using Stocks.ViewComponents;
using System;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;
using Windows.Data.Json;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Media.Animation;

namespace Stocks {
  public sealed partial class MainPage : Page {

    public StockQuote SelectedIndexQuote { get; set; }
    public StockQuote SelectedStockQuote { get; set; }

    public MainPage() {
      InitializeComponent();
    }

    private void IndicesPage_StockQuoteSelected(object sender, StockQuoteSelectedEventArgs e) {
      if (AdaptiveVisualStates.CurrentState == NarrowState) {
        NavigateToStockDetail(e.Quote);
      } else {
        SelectedIndexQuote = e.Quote;
        Bindings.Update();
      }
    }

    private void WatchListPage_StockQuoteSelected(object sender, StockQuoteSelectedEventArgs e) {
      if (AdaptiveVisualStates.CurrentState == NarrowState) {
        NavigateToStockDetail(e.Quote);
      } else {
        SelectedStockQuote = e.Quote;
        Bindings.Update();
      }
    }

    private void NavigateToStockDetail(StockQuote quote) {
      Frame.Navigate(typeof(StockQuoteDetailView), quote, new DrillInNavigationTransitionInfo());
    }

  }
}
