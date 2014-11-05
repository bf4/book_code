#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
When /^I view the league page$/ do
  visit '/lawn_darts.html'
end

Then /^I should see the following teams:$/ do |expected|
  rows   = find('table:nth-of-type(2)').all('tr')             
  actual = rows.map { |r| r.all('th,td').map { |c| c.text } } 
  expected.diff! actual                                       
end
