#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
Given /^I am logged in as an admin$/ do
  Administrator.create! :username => 'admin', :password => 'admin'
  basic_auth 'admin', 'admin'
end

Given /^the following restaurants:$/ do |restaurants|
  Restaurant.create!(restaurants.hashes)
end

When /^I add the following restaurants?:$/ do |restaurants|
  restaurants.hashes.each do |r|
    visit new_restaurant_path
    fill_in 'restaurant[name]', :with => r[:name]
    click_button 'Create'
  end
end

Then /^I should see the following restaurants:$/ do |expected|
  visit restaurants_path

  actual = table(tableish('table:nth-of-type(2) tr', 'td,th'))
  actual.map_headers! { |h| h.downcase }

  expected.diff! actual
end
