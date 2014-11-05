#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'icalendar'
class Meeting < ActiveRecord::Base
  def add_to_calendar(calendar)
    meeting = self
    calendar.event do
      dtstart meeting.starts_at.to_datetime
      dtend meeting.ends_at.to_datetime
      description meeting.description
    end
  end
end
