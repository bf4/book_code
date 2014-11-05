#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'waveform'

sine_wave = (0..360).map do |degrees|
  radians = degrees * Math::PI / 180.0
  Math.sin radians
end

waveform = Waveform.new sine_wave

puts waveform.rms
# >> 0.706126729736776
