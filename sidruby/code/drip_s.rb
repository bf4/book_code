#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drip'
require 'drb'

class Drip
  def quit
    Thread.new do
      synchronize do |key|
        exit(0)
      end
    end
  end
end

drip = Drip.new('drip_dir')
DRb.start_service('druby://localhost:54321', drip)
DRb.thread.join
