#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
When /^I search the forums for "([^"]*)"$/ do |term|
  escaped = CGI::escape term
  visit "http://forums.pragprog.com/search?q=#{escaped}"
end

Then /^I should see the most recent posts first$/ do
  doc = Nokogiri::HTML response_body
  dates = doc.css('div.date').map { |e| Time.parse e.text }
  dates.should have_at_least(1).item
  dates.should == dates.sort.reverse
end
