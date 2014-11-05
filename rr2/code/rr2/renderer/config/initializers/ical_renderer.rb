#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ActionController::Renderers.add :ical do |obj, options|
  filename = options[:filename] || 'events.ics'
  calendar = Icalendar::Calendar.new
  obj.each do |event|
    event.add_to_calendar(calendar)
  end
  send_data calendar.to_ical, :type => Mime::ICS,
                              :disposition => "attachment; filename=#{filename}"
end
