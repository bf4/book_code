#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^an order for (\d+) tons of material$/ do |tons|
end

=begin
When /^I pack (\d+) shipping containers$/ do |count|
  last = count.to_i

  (1..last).each do |i|
    Shipping.pack_container i
  end
end
=end

When /^I pack (\d+) shipping containers$/ do |count|
  last = count.to_i

  Parallel.each(1..last) do |i|
    Shipping.pack_container i
  end
end

Then /^the order should be complete$/ do
end
