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

using Xamarin.Forms;
using Calc;
using System.Dynamic;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;

namespace CalcForms {
  public partial class CalculatorPage : ContentPage {

    public CalculatorPage() {
      InitializeComponent();
      AddButtons();
    }

    public void ButtonClicked(object sender, EventArgs eventArgs) {
      var button = (Button)sender;
      string label = button.Text;
      model.Input(label);
    }

    void AddButtons() {
      var buttons = CalculatorModel.buttons;
      var column = 0;
      var row = -1;
      for (int i = 0; i < buttons.Length; i++) {
        column = i % 4;
        if (column == 0) { row++; }
        var label = buttons[i];
        var button = CreateButton(label);
        ButtonGrid.Children.Add(button, column, row);
      }
      var convertButton = new Button();
      convertButton.Text = "$ > €";
      convertButton.Clicked += Convert;
      ButtonGrid.Children.Add(convertButton, ++column, row);
    }

    Button CreateButton(string label) {
      var button = new Button();
      button.Text = label;
      button.Clicked += ButtonClicked;
      return button;
    }

    async void Convert(object sender, EventArgs e) {
      string converted = await ConvertUSDToEUR(model.Display);
      model.ReplaceCurrentValue(converted);
    }

    async Task<string> ConvertUSDToEUR(string amount) {
      var client = new HttpClient();
      string url = "http://localhost:3000/convert/";
      Device.OnPlatform(
        // Use this for emulator url = "http://10.0.2.2:3000";
        // Use this for genymotion url = "http://10.0.3.2:3000";

        Android: () => {
          url = "http://10.0.2.2:3000/convert/";
        }
      );
      client.BaseAddress = new Uri(url);
      client.DefaultRequestHeaders.Accept.Add(
        new MediaTypeWithQualityHeaderValue("application/json")
      );
      var response = await client.GetAsync("USD/EUR");
      var json = response.Content.ReadAsStringAsync().Result;
      var rateInfo = JsonConvert.DeserializeObject<ConversionRate>(json);
      var convertedAmount = float.Parse(amount) * rateInfo.rate;
      return convertedAmount.ToString();
    }

  }

  class ConversionRate {
    public string name { get; set; }
    public string from { get; set; }
    public string to   { get; set; }
    public float  rate { get; set; }
  }
}

