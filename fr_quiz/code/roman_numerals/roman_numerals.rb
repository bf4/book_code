#!/usr/bin/ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

#
# Roman numerals
#
# Generates roman numerals from integers and vice-versa
#
# A response to Ruby Quiz of the Week #21 - Roman Numerals [ruby-talk:132925]
#
# Author: Dave Burt <dave at burt.id.au>
#
# Created: 7 Mar 2005
#
# Last modified: 8 Mar 2005
#
# Fine print: Provided as is. Use at your own risk. Unauthorized copying is
#             not disallowed. Credit's appreciated if you use my code. I'd
#             appreciate seeing any modifications you make to it.
#


# Contains methods to convert integers to Roman numeral strings, and vice versa.
module RomanNumerals
  
  # Maps Roman numeral digits to their integer values
  DIGITS = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }
  
  # The largest integer representable as a Roman numerable by this module
  MAX = 3999
  
  # Maps some integers to their Roman numeral values
  @@digits_lookup = DIGITS.inject({
    4 => 'IV',
    9 => 'IX',
    40 => 'XL',
    90 => 'XC',
    400 => 'CD',
    900 => 'CM'}) do |memo, pair|
    memo.update({pair.last => pair.first})
  end
  
  # Based on Regular Expression Grabbag in the O'Reilly Perl Cookbook, #6.23
  REGEXP = /^M*(D?C{0,3}|C[DM])(L?X{0,3}|X[LC])(V?I{0,3}|I[VX])$/i
  
  # Converts +int+ to a Roman numeral
  def self.from_integer(int)
    return nil if int < 0 || int > MAX
    remainder = int
    result = ''
    @@digits_lookup.keys.sort.reverse.each do |digit_value|
      while remainder >= digit_value
        remainder -= digit_value
        result += @@digits_lookup[digit_value]
      end
      break if remainder <= 0
    end
    result
  end
  
  # Converts +roman_string+, a Roman numeral, to an integer
  def self.to_integer(roman_string)
    return nil unless roman_string.is_roman_numeral?
    last = nil
    roman_string.to_s.upcase.split(//).reverse.inject(0) do |memo, digit|
      if digit_value = DIGITS[digit]
        if last && last > digit_value
          memo -= digit_value
        else
          memo += digit_value
        end
        last = digit_value
      end
      memo
    end
  end
  
  # Returns true if +string+ is a Roman numeral.
  def self.is_roman_numeral?(string)
    REGEXP =~ string
  end
end



class String
  # Considers string a Roman numeral,
  # and converts it to the corresponding integer.
  def to_i_roman
    RomanNumerals.to_integer(self)
  end
  # Returns true if the subject is a Roman numeral.
  def is_roman_numeral?
    RomanNumerals.is_roman_numeral?(self)
  end
end
class Integer
  # Converts this integer to a Roman numeral.
  def to_s_roman
    RomanNumerals.from_integer(self) || ''
  end
end



# Integers that look like Roman numerals
class RomanNumeral
  attr_reader :to_s, :to_i

  @@all_roman_numerals = []

  # May be initialized with either a string or an integer
  def initialize(value)
    case value
    when Integer
      @to_s = value.to_s_roman
      @to_i = value
    else
      @to_s = value.to_s
      @to_i = value.to_s.to_i_roman
    end
    @@all_roman_numerals[to_i] = self
  end

  # Factory method: returns an equivalent existing object if such exists,
  # or a new one
  def self.get(value)
    if value.is_a?(Integer)
      to_i = value
    else
      to_i = value.to_s.to_i_roman
    end
    @@all_roman_numerals[to_i] || RomanNumeral.new(to_i)
  end

  def inspect
    to_s
  end

  # Delegates missing methods to Integer, converting arguments to Integer,
  # and converting results back to RomanNumeral
  def method_missing(sym, *args)
    unless to_i.respond_to?(sym)
      raise NoMethodError.new(
        "undefined method '#{sym}' for #{self}:#{self.class}")
    end
    result = to_i.send(sym,
      *args.map {|arg| arg.is_a?(RomanNumeral) ? arg.to_i : arg })
    case result
    when Integer
      RomanNumeral.get(result)
    when Enumerable
      result.map do |element|
        element.is_a?(Integer) ? RomanNumeral.get(element) : element
      end
    else
      result
    end
  end
end



# Enables uppercase Roman numerals to be used interchangeably with integers.
# They are autovivified RomanNumeral constants
# Synopsis:
#   4 + IV           #=> VIII
#   VIII + 7         #=> XV
#   III ** III       #=> XXVII
#   VIII.divmod(III) #=> [II, II]
def Object.const_missing sym
  unless RomanNumerals::REGEXP === sym.to_s
    raise NameError.new("uninitialized constant: #{sym}")
  end
  const_set(sym, RomanNumeral.get(sym))
end



# Quiz solution: filter that swaps Roman and arabic numbers
if __FILE__ == $0
  ARGF.each do |line|
    line.chomp!
    if line.is_roman_numeral?
      puts line.to_i_roman
    else
      puts line.to_i.to_s_roman
    end
  end
end

