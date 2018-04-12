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
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Stocks.Data {
  public class StockQuoteDataModel : INotifyPropertyChanged {

    private List<StockQuote> quotes;
    public List<StockQuote> QuoteList {
      get { return quotes; }
      protected set {
        quotes = value;
        NotifyPropertyChanged("QuoteList");
      }
    }

    public StockQuoteDataModel() {
      QuoteList = new List<StockQuote>();
    }

    public async void GetQuotesForSymbols(string symbols) {
      var request = new StockQuoteRequest();
      var message = await request.RequestStockQuotes(symbols);
      QuoteList = message.Quotes;
    }

    public event PropertyChangedEventHandler PropertyChanged;
    protected void NotifyPropertyChanged(string name) {
      if (name != null && PropertyChanged != null) {
        PropertyChanged(this, new PropertyChangedEventArgs(name));
      }
    }
  }
}
