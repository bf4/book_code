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
        if (label == "=") {
          Grid.SetColumnSpan(button, 2);
        }
      }
    }

    Button CreateButton(string label) {
      var button = new Button();
      button.Text = label;
      button.Clicked += ButtonClicked;
      return button;
    }

  }
}

