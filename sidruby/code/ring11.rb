#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'rinda/ring'
require 'divcal'
require 'ringnotify'

point = ARGV.shift || '/dcal'

DRb.start_service
bartender = Tofu::Bartender.new(DivCal::DivCalSession)

notifier = RingNotify.new(Rinda::RingFinger.primary, :Tofulet)
notifier.each do |tuple|
  tofulet = tuple[2]
  begin
    tofulet.mount(point, bartender)
  rescue
  end
end