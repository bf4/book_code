#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require 'test/unit'


class Integer
  def to_rstr
    "#{self}"
  end
end

class Regexp
  def self.build( *args )
    Regexp.new("^(?:" + args.collect {|a| a.to_rstr}.flatten.uniq.join('|') + ")$")
  end
end

class Range
  def get_regexps( a, b, negative = false )
    arr = [a]

    af = (a == 0 ? 1.0 : a.to_f)
    bf = (b == 0 ? 1.0 : b.to_f)
    1.upto( b.to_s.length-1 ) do |i|
      pot = 10**i
      num = (af/pot).ceil*(pot) # next higher number with i zeros
      arr.insert( i,  num ) if num < b
      num = (bf/pot).floor*(pot) # next lower number with i zeros
      arr.insert( -i, num )
    end
    arr.uniq!
    arr.push( b+1 ) # +1 -> to handle it in the same way as the other elements

    result = []
    0.upto( arr.length - 2 ) do |i|
      first = arr[i].to_s
      second = (arr[i+1] - 1).to_s
      str = ''
      0.upto( first.length-1 ) do |j|
        if first[j] == second[j]
          str << first[j]
        else
          str << "[#{first[j].chr}-#{second[j].chr}]"
        end
      end
      result << str
    end

    result = result.join('|')
    result = "-(?:#{result})" if negative
    result
  end

  def to_rstr
    if first < 0 && last < 0
      get_regexps( -last, -first, true )
    elsif first < 0
      get_regexps( 1, -first, true ) + "|" + get_regexps( 0, last )
    else
      get_regexps( first, last )
    end
  end
end


class RegexpTest < Test::Unit::TestCase
 def rangeTest( first, last )
   r = Regexp.build( first..last )
   assert_match( r, "#{first}" )
   assert_match( r, "#{(first + last)/2}" )
   assert_match( r, "#{last}" )
   assert_no_match( r, "#{first-1}" )
   assert_no_match( r, "#{last+1}" )
 end

 def testBuild
   lucky = Regexp.build( 3, 7 )
   assert_match(lucky, "7")
   assert_no_match(lucky, "13")
   assert_match(lucky, "3")

   rangeTest( 1, 12 )
   month = Regexp.build( 1..12 )
   assert_no_match(month, "0")
   assert_match(month, "1")
   assert_match(month, "12")

   rangeTest( 1, 31 )
   day = Regexp.build( 1..31 )
   assert_match(day, "6")
   assert_match(day, "16")
   assert_no_match(day, "Tues")

   rangeTest( 2000, 2005 )
   year = Regexp.build( 98, 99, 2000..2005 )
   assert_no_match(year, "04")
   assert_match(year, "2004")
   assert_match(year, "99")

   rangeTest( 0, 1000000 )
   num = Regexp.build( 0..1_000_000 )
   assert_no_match(num, "-1")
 end

 def testPositive
   rangeTest( 2, 10 )
   rangeTest( 23432, 12312123 )
 end

 def testNegative
   rangeTest( -10, -2 )
   rangeTest( -15, 4 )
   rangeTest( -100342, -343 )
 end

 def testOther
   rangeTest( 5, 16 )
   rangeTest( 10, 100 )
   rangeTest( 11, 99 )
   rangeTest( 1, 123456789 )
   rangeTest( 10, 10 )
   rangeTest( 5, 5 )
   rangeTest( 0, 5 )
   rangeTest( 0, 10 )
   rangeTest( 1, 5 )
 end

 def testIllegal
   num = Regexp.build( 1..12 )
   assert_no_match( num, "012" )
   assert_no_match( num, "A12" )
   assert_no_match( num, "120" )
   assert_no_match( num, "12A" )
   assert_no_match( num, "3125" )
 end
end
