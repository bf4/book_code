#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'icalendar'

require 'date'
cal = nil

File.open(File.expand_path(File.dirname(__FILE__) + '/recur1.ics')) do |file|
  cal = Icalendar.parse(file).first
end
event = cal.events.first
debugger
puts event.to_ical