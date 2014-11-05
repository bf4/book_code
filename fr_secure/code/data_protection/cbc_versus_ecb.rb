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
require 'base64'

def pretty_print(array)
  puts "#{array.slice!(0,16).inspect}"
  pretty_print(array) unless array.empty?
end

plain_text = String.new
8.times { plain_text << "12345678" }  
cbc_aes = OpenSSL::Cipher::Cipher.new("AES-128-CBC")
ecb_aes = OpenSSL::Cipher::Cipher.new("AES-128-ECB")
key = cbc_aes.random_key
iv = cbc_aes.random_iv

# encrypt string with cipher block chaining mode
cbc_aes.encrypt(key, iv) 
cbc_cipher_text = cbc_aes.update(plain_text)
cbc_cipher_text << cbc_aes.final

puts "aes with mode cbc"
pretty_print(cbc_cipher_text)

# encrypt string with electronic codebook mode
ecb_aes.encrypt(key, iv) 
ecb_cipher_text = ecb_aes.update(plain_text) 
ecb_cipher_text << ecb_aes.final

puts "\naes with mode ecb"
pretty_print(ecb_cipher_text)

