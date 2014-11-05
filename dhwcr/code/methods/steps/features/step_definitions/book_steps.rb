#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^I am on the page for "(.*?)"$/, :visit_book_page
When /^I look for related titles$/,     :find_related_titles
Then /^I should see "(.*?)"$/,          :verify_related_title
