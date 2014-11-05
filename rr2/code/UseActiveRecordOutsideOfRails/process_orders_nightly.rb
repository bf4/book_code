#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
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
ActiveRecord::Base.logger = Logger.new(STDOUT) 

Order.find(:all).each do |o|
  puts "Processing order number #{o.id}"
  `./sendorder -c #{o.customer_id} \
     -p #{o.product_id} \
     -q #{o.quantity}`
end