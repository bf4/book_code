#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# Test out property parameter functionality
$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'pp'
require 'date'
require 'test/unit'
require 'icalendar'

class TestComponent < Test::Unit::TestCase

   # Create a calendar with an event for each test.
   def setup
      @cal = Icalendar::Calendar.new
      @event = Icalendar::Event.new
   end

   def test_property_parameters
     params = {"ALTREP" =>['"http://my.language.net"'], "LANGUAGE" => ["SPANISH"]}
     # params = {"ALTREP" =>["foo"], "LANGUAGE" => ["SPANISH"]}
      @event.summary("This is a test summary.", params)

      assert_equal params, @event.summary.ical_params

      @cal.add_event @event
      cal_str = @cal.to_ical
#       puts cal_str

      cals = Icalendar::Parser.new(cal_str).parse
#       pp cals
      event = cals.first.events.first
      assert_equal params, event.summary.ical_params
   end
end
