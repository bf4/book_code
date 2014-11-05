#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
$: << File.dirname(__FILE__)
require "connect"
require "logger"
require "pp"

#ActiveRecord::Base.logger = Logger.new(STDERR)

#require "rubygems"
#require_gem "active_record"

ActiveRecord::Schema.define do
  create_table :customers, :force => true do |t|
    t.datetime :created_at
    t.decimal  :credit_limit, :precision => 10, :scale => 2, :default => 100
    t.string   :first_name
    t.string   :initials
    t.string   :last_name
    t.datetime :last_purchase
    t.integer  :purchase_count, :default => 0
  end
end

class LastFive
  
  attr_reader :list

  # Takes a string containing "a,b,c" and 
  # stores [ 'a', 'b', 'c' ]
  def initialize(list_as_string)
    @list = list_as_string.split(/,/)
  end


  # Returns our contents as a 
  # comma delimited string
  def last_five
    @list.join(',')
  end
end

class Purchase < ActiveRecord::Base
  composed_of :last_five
end

Purchase.delete_all

Purchase.create(:last_five => LastFive.new("3,4,5"))

purchase = Purchase.find(:first)

puts purchase.last_five.list[1]     #=>  4


class Name
  attr_reader :first, :initials, :last

  def initialize(first, initials, last)
    @first = first
    @initials = initials
    @last = last
  end

  def to_s
    [ @first, @initials, @last ].compact.join(" ")
  end
end

class Customer < ActiveRecord::Base

  composed_of :name,
              :class_name => "Name",
              :mapping => 
                 [ # database       ruby
                   %w[ first_name   first ],
                   %w[ initials     initials ],
                   %w[ last_name    last ] 
                 ]
end

Customer.delete_all

name = Name.new("Dwight", "D", "Eisenhower")

Customer.create(:credit_limit => 1000, :name => name)

customer = Customer.find(:first)
puts customer.name.first    #=> Dwight
puts customer.name.last     #=> Eisenhower
puts customer.name.to_s     #=> Dwight D Eisenhower
customer.name = Name.new("Harry", nil, "Truman")
customer.save

