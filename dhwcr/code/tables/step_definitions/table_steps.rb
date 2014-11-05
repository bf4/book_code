#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^I am logged in as a buyer$/ do
end

When /^I search for available cars$/ do
  @cars = [{'colour' => 'rust', 'model' => 'Camaro'},
           {'colour' => 'blue', 'model' => 'Gremlin'}]
end

Then /^I should see the following cars:$/ do |table|
=begin
  table.map_headers! /colou?r/ => 'colour'
  table.map_headers! { |name| name.sub('color', 'colour') }
=end
  table.map_headers! 'color' => 'colour'
  table.diff! @cars
end

require 'bigdecimal'

When /^I view warranty options$/ do
  _1000 = BigDecimal.new '1000'
  _500  = BigDecimal.new '500'
  _200  = BigDecimal.new '200'

  @warranties = [{'name' => 'Platinum', 'price' => _1000, 'code' => 'P'},
                 {'name' => 'Gold',     'price' => _500,  'code' => 'G'},
                 {'name' => 'Silver',   'price' => _200,  'code' => 'S'}]
end

Then /^I should see the following options:$/ do |table|
  table.map_column!(:price) { |cell| BigDecimal.new(cell.sub('$', '')) }
  table.diff! @warranties

=begin
  table.diff! @warranties, :surplus_col => true
=end

end
