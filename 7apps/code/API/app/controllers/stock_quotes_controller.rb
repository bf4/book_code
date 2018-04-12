#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'net/http'

class StockQuotesController < ActionController::Base

  def index
    @quote_list = StockQuote.for(params[:symbols])
    render "stock_quotes/stock_quotes"
  end

end
