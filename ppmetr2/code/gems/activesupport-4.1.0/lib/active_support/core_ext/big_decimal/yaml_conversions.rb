#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
ActiveSupport::Deprecation.warn 'core_ext/big_decimal/yaml_conversions is deprecated and will be removed in the future.'

require 'bigdecimal'
require 'yaml'
require 'active_support/core_ext/big_decimal/conversions'

class BigDecimal
  YAML_MAPPING = { 'Infinity' => '.Inf', '-Infinity' => '-.Inf', 'NaN' => '.NaN' }

  def encode_with(coder)
    string = to_s
    coder.represent_scalar(nil, YAML_MAPPING[string] || string)
  end
end
