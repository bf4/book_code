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
  java_implements 'Runnable'

  # ... other methods here ...

  java_signature 'void run()'
  def run
    puts 'inside runnable implementation'
    puts rms
  end
end
