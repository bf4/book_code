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
  :username => "root", 
  :password => "", 
  :database => "web_orders"
) 

ActiveRecord::Base.logger = Logger.new(STDOUT) 
ActiveRecord::Schema.define do 
  create_table 'orders' do |t| 
    t.column :customer_id, :integer 
    t.column :product_id, :integer
    t.column :quantity, :integer
    t.column :processed, :boolean
    t.column :created_at, :datetime
  end 
end 
 
