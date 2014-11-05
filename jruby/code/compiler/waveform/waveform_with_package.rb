#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java_package 'com.example'

class Waveform
  java_signature 'Waveform(double[] points)'
  def initialize(points)
    @points = points
  end

  java_signature 'double rms()'
  def rms
    raise 'No points' unless @points.length > 0
    squares = @points.map {|p| p * p}
    sum     = squares.inject {|s, p| s + p}
    mean    = sum / squares.length
    Math.sqrt(mean)
  end
end
