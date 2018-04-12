/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
﻿using NotificationsExtensions.Tiles;
using Stocks.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Notifications;

namespace Stocks.Data {
  public class TileHelper {
    public static TileNotification TileNotificationForQuotes(
                                     ICollection<StockQuote> quotes) {
      var nameSubgroup = new TileSubgroup();
      var upDownSubgroup = new TileSubgroup();
      int count = 3;
      foreach (var quote in quotes) {
        nameSubgroup.Children.Add(CreateNameTextForQuote(quote));
        upDownSubgroup.Children.Add(CreateArrowTextForQuote(quote));
        count--;
        if (count == 0) {
          break;
        }
      }

      var group = new TileGroup();
      group.Children.Add(nameSubgroup);
      group.Children.Add(upDownSubgroup);

      var content = new TileContent() {
        Visual = new TileVisual() {
          TileMedium = new TileBinding() {
            Content = new TileBindingContentAdaptive() {
              Children = {
                group
              }
            }
          },
          TileWide = new TileBinding() {
            Content = new TileBindingContentAdaptive() {
              Children = {
                group
              }
            }
          }
        }
      };

      var doc = content.GetXml();
      return new TileNotification(doc);
    }

    private static TileText CreateNameTextForQuote(StockQuote quote) {
      return new TileText {
        Text = quote.Symbol,
        Style = TileTextStyle.Body
      };
    }

    private static TileText CreateArrowTextForQuote(StockQuote quote) {
      return new TileText {
        Text = quote.IsDown ? "▼" : "▲",
        Style = TileTextStyle.Body,
        Align = TileTextAlign.Right
      };
    }
  }
}
