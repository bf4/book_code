#!/usr/local/bin/ruby
#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'cgi_reminder'
require 'drb/drb'

reminder = DRbObject.new_with_uri('druby://localhost:12345')
cgi = ReminderCGI.new(reminder)
DRb.start_service('druby://localhost:12346', cgi)
DRb.thread.join

