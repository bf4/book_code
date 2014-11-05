#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  module JSON
    class CircularReferenceError < StandardError
    end

    # Converts a Ruby object into a JSON string.
    def self.encode(value, options = {})
      seen = (options[:seen] ||= [])
      raise CircularReferenceError, 'object references itself' if seen.include?(value)
      seen << value
      value.send(:to_json, options)
    ensure
      seen.pop
    end
  end
end

require 'active_support/json/variable'
require 'active_support/json/encoders/date'
require 'active_support/json/encoders/date_time'
require 'active_support/json/encoders/enumerable'
require 'active_support/json/encoders/false_class'
require 'active_support/json/encoders/hash'
require 'active_support/json/encoders/nil_class'
require 'active_support/json/encoders/numeric'
require 'active_support/json/encoders/object'
require 'active_support/json/encoders/regexp'
require 'active_support/json/encoders/string'
require 'active_support/json/encoders/symbol'
require 'active_support/json/encoders/time'
require 'active_support/json/encoders/true_class'
