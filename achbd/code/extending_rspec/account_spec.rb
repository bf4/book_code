#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Money
  def initialize(amount, currency)
    @amount, @currency = amount, currency
  end
  def +(other)
    self
  end
  def -(other)
    self
  end
  def to_s
    "<Money: #{@amount} #{@currency}"
  end
end

class Account
  def balance
    Money.new(0, :USD)
  end
  def deposit(amount)
    
  end
end

describe Account do
  describe "#deposit" do
    it "adds the deposited amount to its balance" do
      account = Account.new
      lambda do
        account.deposit(Money.new(50, :USD))
      end.should change{ account.balance }.by(Money.new(50, :USD))
    end
  end
end
