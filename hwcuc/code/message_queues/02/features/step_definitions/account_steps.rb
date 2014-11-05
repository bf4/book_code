#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
Given /^my account has been credited with (#{CAPTURE_CASH_AMOUNT})$/ do |amount|
  my_account.credit(amount)
end

Then /^the balance of my account should be (#{CAPTURE_CASH_AMOUNT})$/ do |amount|
  sleep 1
  my_account.balance.should eq(amount)
end

