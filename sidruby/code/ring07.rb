#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'rinda/ring'
require './ringnotify'

DRb.start_service

ts = Rinda::RingFinger.primary
ns = RingNotify.new(ts, :Hello)
ns.each do |tuple|
  hello = tuple[2]
  begin
    puts hello.greeting
  rescue
  end
end
