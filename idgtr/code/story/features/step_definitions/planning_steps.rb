#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
Given /^a party called "(.*)"$/ do |name|
  @party = Party.new(browser)
  @party.name = name
end

Given /^a description of "(.*)"$/ do |desc|
  @party.description = desc
end

Given /^a location of "(.*)"$/ do |loc|
  @party.location = loc
end

Given /an? (.*) time of (.*)/ do |event, sometime|   #(1)
  clean = sometime.gsub ',', ' '
  date_time = Chronic.parse clean, :now => Time.now - 86400 #(2)

  if event == 'starting'
    @party.begins_at = date_time
  else
    @party.ends_at = date_time
  end
end

When /^I view the invitation$/ do
  @party.save_and_view
end
