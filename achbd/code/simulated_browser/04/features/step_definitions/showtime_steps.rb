#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
Given /^a movie$/ do
  @movie = Movie.create!
end

When /^I set the showtime to "([^"]*)" at "([^"]*)"$/ do |date, time|
  @movie.update_attribute(:showtime_date, Date.parse(date))
  @movie.update_attribute(:showtime_time, time)
end

Then /^the showtime description should be "([^"]*)"$/ do |showtime|
  @movie.showtime.should eq(showtime)
end
