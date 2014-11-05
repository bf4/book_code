#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Customer < ActiveRecord::Base
  composed_of :address, :mapping => [ %w(address_street street), %w(address_city city), %w(address_country country) ]
  composed_of :balance, :class_name => "Money", :mapping => %w(balance amount)
end

class Address
  attr_reader :street, :city, :country

  def initialize(street, city, country)
    @street, @city, @country = street, city, country
  end
  
  def close_to?(other_address)
    city == other_address.city && country == other_address.country
  end
end

class Money
  attr_reader :amount, :currency
  
  EXCHANGE_RATES = { "USD_TO_DKK" => 6, "DKK_TO_USD" => 0.6 }
  
  def initialize(amount, currency = "USD")
    @amount, @currency = amount, currency
  end
  
  def exchange_to(other_currency)
    Money.new((amount * EXCHANGE_RATES["#{currency}_TO_#{other_currency}"]).floor, other_currency)
  end
end