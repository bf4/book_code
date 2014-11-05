#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
CAPTURE_CASH_AMOUNT = Transform /^\$(\d+)$/ do |digits|
  digits.to_i
end

Given /^I have deposited (#{CAPTURE_CASH_AMOUNT}) in my account$/ do |amount|
  my_account.deposit(amount)
  my_account.balance.should eq(amount), "Expected the balance to be #{amount}"
end

When /^I withdraw (#{CAPTURE_CASH_AMOUNT})$/ do |amount|
  atm.withdraw_from(my_account, amount)
end

Then /^(#{CAPTURE_CASH_AMOUNT}) should be dispensed$/ do |amount|
  cash_slot.contents.should == amount
end