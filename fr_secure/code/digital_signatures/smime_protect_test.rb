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
  
  
  def test_smime_protect
   
   
sender_cert = X509::Certificate.new(File::read('host.cert'))
sender_key = PKey::RSA.new(File::read('host.key'))

data = "This is a clear-signed message.\r\n"
sender_p7sig  = PKCS7::sign(sender_cert, sender_key, data, [], PKCS7::TEXT)
sender_smime = PKCS7::write_smime(sender_p7sig)

lunchedin_cert  = X509::Certificate.new(File::read('lunchedin.gmail.email.cer'))
sender_p7enc = PKCS7::encrypt([lunchedin_cert], sender_smime)
msg = PKCS7::write_smime(sender_p7enc)
  
# decrypt
lunchedin_key = PKey::RSA.new(File::read('lunchedin.gmail.email.key')) 
lunchedin_p7enc = PKCS7::read_smime(msg)
lunchedin_data = lunchedin_p7enc.decrypt(lunchedin_key, lunchedin_cert)
puts lunchedin_data.inspect
   
   
   puts "==== Expected ===="
   puts sender_p7sig
   puts "==== Actual ===="   
   puts lunchedin_p7enc
    
  end
  
  
end
    
