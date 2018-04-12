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
using System.Text;
using System.Threading.Tasks;
using Windows.UI;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Media;

namespace Stocks.ValueConverters {

  public class IsDownToColorConverter : IValueConverter {

    public SolidColorBrush UpColorBrush { get; set; }
    public SolidColorBrush DownColorBrush { get; set; }

    public object Convert(object value, Type targetType, object parameter, string language) {
      if ((bool)value) { // is the stock down?
        return DownColorBrush;
      } else {
        return UpColorBrush;
      }
    }

    public object ConvertBack(object value, Type targetType, object parameter, string language) {
      throw new NotImplementedException();
    }
  }
}
