#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'rubygems'
require 'spec'

class Money
  attr_reader :amount, :currency
  
  def initialize(amount, currency)
    @amount, @currency = amount, currency
  end
  
  def ==(other)
    self.amount == other.amount && self.currency == other.currency
  end
end

describe Money do
  describe "#==" do
    it "returns true if the amount and currency are the same" do
      Money.new(5, :USD).should == Money.new(5, :USD)
    end
  end
end

class Account
  attr_reader :balance
  
  def initialize(starting_balance, currency)
    @balance = Money.new(starting_balance, currency)
  end
  
  def deposit(money)
  end
end

describe Account do
  describe "#deposit" do
    it "adds the amount deposited to the balance" do
      account = Account.new(0, :USD)
      account.deposit(Money.new(5, :USD))
      account.balance.should == Money.new(5, :USD)
    end
  end
end