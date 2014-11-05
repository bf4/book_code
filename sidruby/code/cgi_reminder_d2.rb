#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'reminder0'
require 'drb/drb'
require 'pp'
require 'cgi_reminder'

reminder = Reminder.new
reminder.add('RubyKaigi 2011応募')
reminder.add('ポモドーロタイマーを買う')
reminder.add('<や>はどうなるの？')

cgi = ReminderCGI.new(reminder)
DRb.start_service('druby://localhost:12346', cgi)

while true
  sleep 10
  pp front.to_a
end
