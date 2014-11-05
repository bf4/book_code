#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


ROMAN_MAP = { 1    => "I",
              4    => "IV",
              5    => "V",
              9    => "IX",
              10   => "X",
              40   => "XL",
              50   => "L",
              90   => "XC",
              100  => "C",
              400  => "CD",
              500  => "D",
              900  => "CM",
              1000 => "M" }


ROMAN_NUMERALS = Array.new(3999) do |index|
  target = index + 1
  ROMAN_MAP.keys.sort { |a, b| b <=> a }.inject("") do |roman, div|
    times, target = target.divmod(div)
    roman << ROMAN_MAP[div] * times
  end
end



IS_ROMAN = / ^ M{0,3}
               (?:CM|DC{0,3}|CD|C{0,3})
               (?:XC|LX{0,3}|XL|X{0,3})
               (?:IX|VI{0,3}|IV|I{0,3}) $ /ix
IS_ARABIC = /^(?:[123]\d{3}|[1-9]\d{0,2})$/



if __FILE__ == $0
  ARGF.each_line() do |line|
    line.chomp!
    case line
    when IS_ROMAN  then puts ROMAN_NUMERALS.index(line) + 1
    when IS_ARABIC then puts ROMAN_NUMERALS[line.to_i - 1]
    else raise "Invalid input:  #{line}"
    end
  end
end

