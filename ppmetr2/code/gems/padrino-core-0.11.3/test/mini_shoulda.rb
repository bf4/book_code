#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
gem 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/setup'

begin
  require 'ruby-debug'
rescue LoadError; end

class MiniTest::Spec
  class << self
    alias :setup :before unless defined?(Rails)
    alias :teardown :after unless defined?(Rails)
    alias :should :it
    alias :context :describe
    def should_eventually(desc)
      it("should eventually #{desc}") { skip("Should eventually #{desc}") }
    end
  end
  alias :assert_no_match  :refute_match
  alias :assert_not_nil   :refute_nil
  alias :assert_not_equal :refute_equal
end

class ColoredIO
  def initialize(io)
    @io = io
  end

  def print(o)
    case o
    when "." then @io.send(:print, o.green)
    when "E" then @io.send(:print, o.red)
    when "F" then @io.send(:print, o.yellow)
    when "S" then @io.send(:print, o.magenta)
    else @io.send(:print, o)
    end
  end

  def puts(*o)
    super
  end
end

MiniTest::Unit.output = ColoredIO.new(MiniTest::Unit.output)
