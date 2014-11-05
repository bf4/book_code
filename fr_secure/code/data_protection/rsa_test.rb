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
include OpenSSL

rsa = PKey::RSA.generate(512) 
txt = "Chunky Bacon"
puts "Plain Text: #{txt}"

cipher_text_with_priv = rsa.private_encrypt(txt) 
cipher_text_with_pub = rsa.public_encrypt(txt) 

puts "== Plain Text Decrypted With Public Key =="
puts pt_with_pub = rsa.public_decrypt(cipher_text_with_priv) 

puts "== Plain Text Decrypted With Private Key =="
puts pt_with_priv = rsa.private_decrypt(cipher_text_with_pub) 