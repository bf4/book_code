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
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;

namespace Stocks.Data {
  class StockQuoteRequest {

    public async Task<QuoteMessage> RequestStockQuotes(string quoteList) {
      var httpClient = new HttpClient();
      httpClient.BaseAddress = new Uri("http://localhost:3000/stock_quotes/");
      httpClient.DefaultRequestHeaders.Accept.Add(
        new MediaTypeWithQualityHeaderValue("application/json")
      );
      var response = await httpClient.GetAsync(quoteList);
      var messageBody = await response.Content.ReadAsStringAsync();
      var serializer = new DataContractJsonSerializer(typeof(QuoteMessage));
      var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(messageBody));
      var quoteMessage = (QuoteMessage)serializer.ReadObject(memoryStream);
      return quoteMessage;
    }
  }
}
