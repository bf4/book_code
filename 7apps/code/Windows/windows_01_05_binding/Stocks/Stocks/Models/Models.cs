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
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Stocks.Models {

  [DataContract]
  public class QuoteMessage {

    [DataMember(Name = "quotes")]
    public List<StockQuote> Quotes { get; set; }

  }

  [DataContract]
  public class StockQuote {

    [DataMember(Name = "name")]
    public string Name { get; set; }

    [DataMember(Name = "symbol")]
    public string Symbol { get; set; }
    
    [DataMember(Name = "ask")]
    public string Ask { get; set; }

    [DataMember(Name = "bid")]
    public string Bid { get; set; }

    [DataMember(Name = "change")]
    public string Change { get; set; }

    [DataMember(Name = "open")]
    public string Open { get; set; }

    [DataMember(Name = "ebitda")]
    public string EBITDA { get; set; }

    [DataMember(Name = "currency")]
    public string Currency { get; set; }

    [DataMember(Name = "percent_change")]
    public string PercentChange { get; set; }

    [DataMember(Name = "stock_exchange")]
    public string StockExchange { get; set; }

    [DataMember(Name = "last_trade_price_only")]
    public string LastTradePriceOnly { get; set; }

    [DataMember(Name = "last_trade_time")]
    public string LastTradeTime { get; set; }

    [DataMember(Name = "last_trade_date")]
    public string LastTradeDate { get; set; }

    [DataMember(Name = "market_capitalization")]
    public string MarketCapitalization { get; set; }

  }
}
