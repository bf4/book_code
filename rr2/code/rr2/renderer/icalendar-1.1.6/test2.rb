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
require "tzinfo"
require "icalendar/tzinfo"
include Icalendar


# Now, you can make timezones like this
tz = TZInfo::Timezone.get("America/Chicago")

cal = Calendar.new

cal.add(tz.ical_timezone(DateTime.now))

e = cal.event do
    dtstart       DateTime.new(2008, 12, 29, 8, 0, 0)
    dtend         DateTime.new(2008, 12, 29, 11, 0, 0)
    summary     "Meeting with the man."
    description "Have a long lunch meeting and decide nothing..."
    klass       "PRIVATE"
  end

#e.dtstart.ical_params = {"TZID" => "America/Chicago"}
#e.dtend.ical_params = {"TZID" => "America/Chicago"}

puts cal.to_ical

