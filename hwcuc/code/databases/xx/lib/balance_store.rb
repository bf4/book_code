#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require 'fileutils'
require_relative 'account_balance'

class BalanceStore

  def initialize
  end

  def balance
    record.balance
  end

  def balance=(new_balance)
    record.tap { |r| r.balance = new_balance; r.save! }
  end

private

  def record
    AccountBalance.first || AccountBalance.create!(:balance => 0)
  end

end
