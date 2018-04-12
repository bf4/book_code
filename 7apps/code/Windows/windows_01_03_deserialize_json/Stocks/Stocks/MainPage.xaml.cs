/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Windows.Data.Json;
using Windows.UI.Xaml.Controls;

namespace Stocks {
  public sealed partial class MainPage : Page {
    public MainPage() {
      this.InitializeComponent();
      LoadAndDisplayStocks();
    }

    async void LoadAndDisplayStocks() {
      var jsonString = await GetStockIndices();
      var json = JsonObject.Parse(jsonString);
      var stocks = json.GetNamedArray("quotes", new JsonArray());
      var stringBuilder = new StringBuilder();
      foreach (IJsonValue item in stocks) {
        JsonObject stock = item.GetObject();
        stringBuilder.Append(stock["name"].GetString() + "\n");
      }
      StockList.Text = stringBuilder.ToString();
    }

    async Task<string> GetStockIndices() {
      var httpClient = new HttpClient();
      httpClient.BaseAddress = new Uri("http://localhost:3000/stock_quotes/");
      httpClient.DefaultRequestHeaders.Accept.Add(
        new MediaTypeWithQualityHeaderValue("application/json")
      );
      string indexList = "^IXIC,^GSPC,^FTSE,^N225";
      var response = await httpClient.GetAsync(indexList);
      var responseBody = response.Content.ReadAsStringAsync().Result;
      return responseBody;
    }
  }
}
