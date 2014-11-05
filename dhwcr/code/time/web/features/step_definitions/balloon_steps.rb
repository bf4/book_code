#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^a balloon$/ do
  visit 'http://localhost:4567/inflate'
end

When /^I inflate it for (\d+) seconds$/ do |seconds|
=begin
  sleep seconds.to_f
  visit 'http://localhost:4567/status'
=end

  Timecop.freeze(seconds.to_i) do
  
    visit 'http://localhost:4567/status'
	
  end
end

Then /^it should pop$/ do
  page.should have_content 'Popped!'
end
