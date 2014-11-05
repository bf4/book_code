#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drb/drb'
class FactServer
  def initialize(ts)
    @ts = ts
  end
  def main_loop
    loop do
      tuple = @ts.take({"request"=>"fact", "range"=>Range})
      value = tuple["range"].inject(1) { |a, b| a * b }
      @ts.write({"answer"=>"fact", "range"=>tuple["range"], "fact"=>value})
    end
  end
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
FactServer.new($ts).main_loop