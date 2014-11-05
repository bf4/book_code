#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'csv'
class ExportController < ApplicationController
  def orders
    content_type = if request.user_agent =~ /windows/i
                     'application/vnd.ms-excel'
                   else
                     'text/csv'
                   end
     
    CSV::Writer.generate(output = "") do |csv|
      Order.find(:all).each do |order|
        csv << [order.id, order.price, order.purchaser, order.created_at]
      end
    end
    send_data(output, 
                :type => content_type, 
                :filename => "orders.csv")
  end
end
