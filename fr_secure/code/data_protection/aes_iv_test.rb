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

plain_text = "To the limit!"
algorithm = "AES-128-CBC" 
aes = OpenSSL::Cipher::Cipher.new(algorithm) 
key = aes.random_key
iv = aes.random_iv

puts %(clear plain_text:    "#{plain_text}")
puts %(symmetric key: #{key.inspect})
puts %(initialization vector: "#{iv.inspect}")
puts %(cipher alg:    "#{algorithm}")

aes.encrypt(key, iv) 
cipher_text = aes.update(plain_text) 
cipher_text << aes.final
puts %(encrypted plain_text: #{cipher_text.inspect})

# clear the aes cipher
aes.reset 

# decrypt and display output
aes.decrypt(key, iv) 
out = aes.update(cipher_text)
out << aes.final
puts %(decrypted plaintext: "#{out}")