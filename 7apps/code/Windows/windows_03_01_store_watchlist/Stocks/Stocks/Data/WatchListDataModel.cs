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
using Windows.Storage;

namespace Stocks.Data {
  public class WatchListDataModel : StockQuoteDataModel {

    private SortedSet<string> watchedSymbols;
    public SortedSet<string> WatchedSymbols {
      get { return watchedSymbols; }
      protected set {
        watchedSymbols = value;
        StoreSavedWatchedSymbols();
        LoadWatchedSymbols();
      }
    }

    public WatchListDataModel() : base() {
      LoadSavedWatchedSymbols();
    }

    public void AddWatchedSymbol(string symbol) {
      var newSymbols = watchedSymbols;
      newSymbols.Add(symbol);
      WatchedSymbols = newSymbols;
    }

    private void LoadWatchedSymbols() {
      GetQuotesForSymbols(SymbolsAsList());
    }

    private void LoadSavedWatchedSymbols() {
      var settings = ApplicationData.Current.LocalSettings;
      string symbolList = settings.Values["WatchList"] as string;
      if (string.IsNullOrWhiteSpace(symbolList)) {
        WatchedSymbols = new SortedSet<string>();
      } else {
        WatchedSymbols = new SortedSet<string>(symbolList.Split(','));
      }
    }

    private void StoreSavedWatchedSymbols() {
      var settings = ApplicationData.Current.LocalSettings;
      settings.Values["WatchList"] = SymbolsAsList();
    }

    private string SymbolsAsList() {
      return string.Join(",", watchedSymbols.ToArray());
    }

  }
}
