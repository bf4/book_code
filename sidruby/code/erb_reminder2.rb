#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'erb'
require 'drb/drb'

class ReminderView
  include ERB::Util
  extend ERB::DefMethod
  def_erb_method('to_html(there)', 'erb_reminder2.erb')
end

there = DRbObject.new_with_uri('druby://localhost:12345')
view = ReminderView.new
puts view.to_html(there)

