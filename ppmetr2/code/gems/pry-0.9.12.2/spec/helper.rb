#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
unless Object.const_defined? 'Pry'
  $:.unshift File.expand_path '../../lib', __FILE__
  require 'pry'
end

require 'mocha/api'

require 'pry/test/helper'
require 'helpers/bacon'
require 'helpers/mock_pry'

class Module
  public :remove_const
  public :remove_method
end

# turn warnings off (esp for Pry::Hooks which will generate warnings
# in tests)
$VERBOSE = nil

Pad = OpenStruct.new
def Pad.clear
  @table = {}
end

# to help with tracking down bugs that cause an infinite loop in the test suite
if ENV["SET_TRACE_FUNC"]
  require 'set_trace' if Pry::Helpers::BaseHelpers.rbx?
  set_trace_func proc { |event, file, line, id, binding, classname|
     STDERR.printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
  }
end

puts "Ruby v#{RUBY_VERSION} (#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : "ruby"}), Pry v#{Pry::VERSION}, method_source v#{MethodSource::VERSION}, CodeRay v#{CodeRay::VERSION}, Slop v#{Slop::VERSION}"
