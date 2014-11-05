#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rubygems' 
require 'active_record' 
 
ActiveRecord::Base.establish_connection(
  :adapter  => "mysql", 
  :host     => "localhost", 
  :username => "nightlybatch", 
  :password => "secret", 
  :database => "web_orders"
)
   

class Order < ActiveRecord::Base
end

100.times { 
  Order.create(:product_id => rand(10000), :customer_id => rand(1000), :quantity => rand(4))
}
   