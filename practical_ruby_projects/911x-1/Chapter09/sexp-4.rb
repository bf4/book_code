require 'rubygems'
require 'rparsec'

module SExpressionParser
  extend Parsers

  Integer = integer.map{|x| x.to_i }
  Float = number.map{|x| x.to_f }
  Number = longest(Integer, Float)
  # Symbol = word.map {|x| x.to_sym }
  # Symbol = regexp(/\w+/).map{|x| x.to_sym }
  # Symbol = regexp(/[\w]*[A-Za-z][\w]*/).map{|s| s.to_sym }
  # Symbol = regexp(/[\w+\-*\/]*[A-Za-z+\-*\/][\w+\-*\/]*/).map{|s| s.to_sym }
  # Special = '+\-*/'
  # Symbol = regexp(/[\w#{Special}]*[A-Za-z#{Special}][\w#{Special}]*/).map{|s| s.to_sym }
  Special = Regexp.escape('+-*/=<>?!@#$%^&:~')
  Symbol = regexp(/[\w#{Special}]*[A-Za-z#{Special}][\w#{Special}]*/).map{|s| s.to_sym }
end
