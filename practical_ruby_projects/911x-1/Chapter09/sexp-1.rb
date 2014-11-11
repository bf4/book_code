require 'rubygems'
require 'rparsec'

module SExpressionParser
  extend Parsers

  Integer = integer.map{|x| x.to_i }
end
