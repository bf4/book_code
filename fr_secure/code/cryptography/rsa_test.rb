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
include OpenSSL
include PKey
include Cipher



class RsaTest < Test::Unit::TestCase
  
  def test_rsa
    

rsa = PKey::RSA.generate(512) 
p "== Plain Text =="
p txt = "Chunky Bacon"

cipher_text_with_priv = rsa.private_encrypt(txt) 
cipher_text_with_pub = rsa.public_encrypt(txt) 

p "== Plain Text Decrypted With Public Key =="
p pt_with_pub = rsa.public_decrypt(cipher_text_with_priv) 

p "== Plain Text Decrypted With Private Key =="
p pt_with_priv = rsa.private_decrypt(cipher_text_with_pub) 


# its chunky
sig = rsa.sign(Digest::SHA1.new, txt)
is_verified = rsa.verify(Digest::SHA1.new, sig, txt)
assert is_verified
assert pt_with_pub == txt
assert pt_with_priv == txt

  end
end