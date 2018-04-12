/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System.Collections.Generic;
using System.Linq;

namespace Stocks.Data {
  public class WatchListDataModel : StockQuoteDataModel {

    private SortedSet<string> watchedSymbols;
    public SortedSet<string> WatchedSymbols {
      get { return watchedSymbols; }
      protected set {
        watchedSymbols = value;
        LoadWatchedSymbols();
      }
    }

    public WatchListDataModel() : base() {
      watchedSymbols = new SortedSet<string>();
    }

    public void AddWatchedSymbol(string symbol) {
      var newSymbols = watchedSymbols;
      newSymbols.Add(symbol);
      WatchedSymbols = newSymbols;
    }

    private void LoadWatchedSymbols() {
      string symbolList = string.Join(",", watchedSymbols.ToArray());
      GetQuotesForSymbols(symbolList);
    }
  }
}
