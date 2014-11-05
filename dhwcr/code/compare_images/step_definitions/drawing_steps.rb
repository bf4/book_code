#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^a white background$/ do
  @canvas = Canvas.new 300, 200, Color::WHITE
end

When /^I draw a green circle$/ do
  green = Color.rgb 0, 255, 0
  @canvas.circle 150, 100, 50, green, green
end

Then /^the result should resemble "([^"]*)"$/ do |filename|
  @canvas.save 'generated.png'
  `perceptualdiff -downsample 2 #{filename} generated.png`
  $?.should be_success
end
