#!/usr/bin/ruby
#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "rubygems"
require "icalendar"
include Icalendar


# Now, you can make timezones like this
cal = Calendar.new
cal.timezone do
    timezone_id             "America/Chicago"
    x_lic_location "America/Chicago"
    
    daylight do
        timezone_offset_from  "-0600"
        timezone_offset_to    "-0500"
        timezone_name         "CDT"
        dtstart               "19700308TO20000"
        add_recurrence_rule   "FREQ=YEARLY;BYMONTH=3;BYDAY=2SU"
    end
    
    standard do
        timezone_offset_from  "-0500"
        timezone_offset_to    "-0600"
        timezone_name         "CST"
        dtstart               "19701101T020000"
        add_recurrence_rule   "YEARLY;BYMONTH=11;BYDAY=1SU"
    end
end

e = cal.event do
    dtstart       DateTime.new(2008, 12, 29, 8, 0, 0)
    dtend         DateTime.new(2008, 12, 29, 11, 0, 0)
    summary     "Meeting with the man."
    description "Have a long lunch meeting and decide nothing..."
    klass       "PRIVATE"
  end


e.dtstart = DateTime.new(2008, 12, 29, 8, 30)
e.dtend = DateTime.new(2008, 12, 29, 9, 30)
cal.events << e


#e.dtstart.ical_params = {"TZID" => "America/Chicago"}
#e.dtend.ical_params = {"TZID" => "America/Chicago"}

puts cal.to_ical

