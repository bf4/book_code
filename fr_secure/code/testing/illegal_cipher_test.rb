#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'test/unit'


require 'openssl'

module OpenSSL
  module Cipher
    class Cipher
      alias :initialize_old :initialize  
    
      def initialize(cipher)
        if cipher.upcase.match(/^DES/)
          raise "Cipher: #{cipher} is not acceptable!"
        else
          initialize_old(cipher)
        end
      end
    end
  end
end



class IllegalCipherTest < Test::Unit::TestCase

  
  def test_des_with_named_cipher
    assert_raises RuntimeError do
      cipher = OpenSSL::Cipher::Cipher.new("DES")
    end
  end
  
  
  
  def test_des_with_cipher_class
    assert_raises RuntimeError do
      cipher = OpenSSL::Cipher::DES.new
    end
  end
  
  
  
  def test_aes_successful
    assert_nothing_raised do
      cipher = OpenSSL::Cipher::Cipher.new("AES128")
    end
  end
  

end