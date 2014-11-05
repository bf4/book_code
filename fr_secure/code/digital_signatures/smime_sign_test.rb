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



class SmimeProtectTest < Test::Unit::TestCase

  def test_smime_write_read
    
msg = "Hello\r\n"
cert = X509::Certificate.new(File::read('lunchedin.gmail.email.cer'))
key = PKey::RSA.new(File::read('lunchedin.gmail.email.key'))
p7sig  = PKCS7::sign(cert, key, msg, [], OpenSSL::PKCS7::DETACHED) 
smime = PKCS7::write_smime(p7sig) 
    
    
    
    to_verify = PKCS7::read_smime(smime) 
    store = X509::Store.new
    store.add_cert(X509::Certificate.new(File::read('email_ca.cer')))
    is_verified = to_verify.verify([], store) 
    
    
    assert(is_verified)
  end

end