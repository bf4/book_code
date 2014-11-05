#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drb/drb'                                           
class Puts                                                  
  def initialize(stream=$stdout)
    @stream = stream
  end

  def puts(str)
    @stream.puts(str)
  end
end
uri = ARGV.shift
DRb.start_service(uri, Puts.new)                            
puts DRb.uri
DRb.thread.join()                                           
