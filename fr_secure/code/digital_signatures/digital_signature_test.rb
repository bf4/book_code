#!/bin/env ruby
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
include OpenSSL



class DigitalSignatureTest < Test::Unit::TestCase
  
  def test_signature

cert = X509::Certificate.new(File.read('host.cert')) 
private_key = PKey::RSA.new(File.read("host.key"))
input = "Loafing is not permitted" 

signature = private_key.sign(Digest::SHA1.new, input) 
is_verified = cert.public_key.verify(Digest::SHA1.new, signature, input) 


assert is_verified == true

  end

end
