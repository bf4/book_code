#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def is_ruby_19?
  RUBY_VERSION == '1.9.1' or RUBY_VERSION == '1.9.2'
end

Encoding.default_internal = Encoding.default_external = "ASCII-8BIT" if is_ruby_19?

require 'rubygems'
require 'spec'

begin
  require "ruby-debug"
rescue LoadError
  # NOP, ignore
end

require File.dirname(__FILE__) + '/../lib/restclient'
