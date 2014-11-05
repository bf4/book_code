#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
$: << File.dirname(__FILE__)
require 'connect'

require 'rubygems'
require 'active_record'
require 'pp'

ActiveRecord::Schema.define do
  create_table :purchases, :force => true do |t|
    t.string :name
    t.text   :last_five
  end
end

class Purchase < ActiveRecord::Base
  serialize :last_five
  # ...
end

purchase = Purchase.new
purchase.name = "Dave Thomas"
purchase.last_five = [ 'shoes', 'shirt', 'socks', 'ski mask', 'shorts' ]
purchase.save

purchase = Purchase.find_by_name("Dave Thomas")
pp purchase.last_five
pp purchase.last_five[3]
