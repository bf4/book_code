#!/bin/env ruby
#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

require 'openssl'
require 'test/unit'



class TripleDesTest < Test::Unit::TestCase
  
  def test_des
    

plain_text = "To the limit!"
algorithm = "DES-EDE3-CBC" 
des = OpenSSL::Cipher::Cipher.new(algorithm) 
key = des.random_key
iv = des.random_iv

puts %(clear plain_text:    "#{plain_text}")
puts %(symmetric key: "#{key}")
puts %(cipher alg:    "#{algorithm}")

des.encrypt(key, iv)
cipher_text = des.update(plain_text)
cipher_text << des.final
puts %(encrypted plain_text: #{cipher_text.inspect})

# clear the aes cipher
des.reset

des.decrypt(key, iv)
out = des.update(cipher_text)
out << des.final
puts %(decrypted plaintext: "#{out}")


    assert plain_text == out

  end
end
