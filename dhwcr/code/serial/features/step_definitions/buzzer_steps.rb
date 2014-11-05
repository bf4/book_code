#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^a new game$/ do
  @port = SerialPort.new ENV['SERIAL_PORT']
  @port.baud = 9600
end

When /^the first buzz comes from (\d+)$/ do |first|
  character = case first
              when 'player 1' then '1'
              when 'player 2' then '2'
              when 'both players' then 'b'
              else raise 'unknown player'
              end

  @port.write character
end

Then /^LED (\d+) should be lit$/ do |led|
  expected = case led
             when 'LED 1' then '1'
             when 'LED 2' then '2'
             when 'both LEDs' then 'b'
             else raise 'unknown LED'
             end

  @port.write '?'
  @port.read.should == expected
end
