#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Order < ActiveRecord::Base
  def self.to_csv
    (output = "").tap do 
      CSV.generate(output) do |csv|
        all.each do |order|
          csv << [order.id, order.price, order.purchaser, order.created_at]
        end
      end    
    end
  end
end
