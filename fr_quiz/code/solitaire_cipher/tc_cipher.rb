#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "test/unit"
require "cipher"

class TestCipher < Test::Unit::TestCase
  def setup
    @keystream = Object.new
    class << @keystream
      def next_letter
        @letters.shift
      end

      def reset
        @letters = "DWJXH YRFDG TMSHP UURXJ".delete(" ").split("")
      end
    end
    @keystream.reset
    @cipher = Cipher.new(@keystream)
  end
  
  def test_normalize
    assert_equal( "CODEI NRUBY LIVEL ONGER",
                  Cipher.normalize("Code in Ruby, live longer!") )
    
    assert_equal( "YOURC IPHER ISWOR KINGX",
                  Cipher.normalize("Your cipher is working!") )
  end
  
  def test_text_to_chars
    assert_equal( [  3, 15,  4,  5,  9,
                    14, 18, 21,  2, 25,
                    12,  9, 22,  5, 12,
                    15, 14,  7,  5, 18 ],
                  Cipher.text_to_chars("CODEI NRUBY LIVEL ONGER") )

    assert_equal( [  4, 23, 10, 24,  8,
                    25, 18,  6,  4,  7,
                    20, 13, 19,  8, 16,
                    21, 21, 18, 24, 10 ],
                  Cipher.text_to_chars("DWJXH YRFDG TMSHP UURXJ") )
  end
  
  def test_chars_to_text
    assert_equal( "GLNCQ MJAFF FVOMB JIYCB",
                  Cipher.chars_to_text( [  7, 12, 14,  3, 17,
                                          13, 10,  1,  6,  6,
                                           6, 22, 15, 13,  2,
                                          10,  9, 25,  3,  2 ] ) )
  end
  
  def test_encrypt
    assert_equal( "GLNCQ MJAFF FVOMB JIYCB",
                  @cipher.encrypt("Code in Ruby, live longer!") )
  end
  
  def test_decrypt
    assert_equal( "CODEI NRUBY LIVEL ONGER",
                  @cipher.decrypt("GLNCQ MJAFF FVOMB JIYCB") )

    @keystream.reset
    assert_equal( "YOURC IPHER ISWOR KINGX",
                  @cipher.decrypt("CLEPK HHNIY CFPWH FDFEH") )

    @keystream.reset
    assert_equal( "WELCO METOR UBYQU IZXXX",
                  @cipher.decrypt("ABVAW LWZSY OORYK DUPVH") )
  end
end
