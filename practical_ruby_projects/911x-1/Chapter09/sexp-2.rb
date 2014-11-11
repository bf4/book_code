require 'rubygems'
require 'rparsec'

module SExpressionParser
  extend Parsers

  Integer = integer.map{|x| x.to_i }
  Float = number.map{|x| x.to_f }
end
