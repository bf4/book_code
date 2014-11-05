#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
class Account
  def deposit(amount)
  end
  
  def balance
  end
end

Given /^I have deposited \$(\d+) in my account$/ do |amount|
  my_account = Account.new
  my_account.deposit(amount.to_i)
  my_account.balance.should eq(amount.to_i), 
    "Expected the balance to be #{amount} but it was #{my_account.balance}"
end

When /^I request \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^\$(\d+) should be dispensed$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end