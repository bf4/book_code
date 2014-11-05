#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'test/unit'
require 'test/unit/assertions'

module Rake
  include Test::Unit::Assertions

  def run_tests(pattern='test/test*.rb', log_enabled=false)
    Dir["#{pattern}"].each { |fn|
      $stderr.puts fn if log_enabled
      begin
        require fn
      rescue Exception => ex
        $stderr.puts "Error in #{fn}: #{ex.message}"
        $stderr.puts ex.backtrace
        assert false
      end
    }
  end

  extend self
end
