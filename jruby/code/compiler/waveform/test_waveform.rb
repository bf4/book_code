#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
require 'waveform_with_sigs'

java_import 'org.junit.Test'

class TestWaveform
  java_annotation 'Test'
  java_signature  'void testRms()'
  def test_rms
    dc = [1.0]
    rms = Waveform.new(dc).rms
    org.junit.Assert.assert_equals rms, 1.0, 0.001
  end
end
