#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java_import 'java.io.PrintStream'

class Waveform
  # ... other methods here ...

  java_signature 'void print(PrintStream)'
  def print(stream)
    stream.write("The RMS is #{rms}")
  end
end
