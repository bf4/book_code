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




class PKCS12Test < Test::Unit::TestCase
  
  def test_pkcs12

pkey = OpenSSL::PKey::RSA.new(512)
cert = OpenSSL::X509::Certificate.new
cert.version = 1
cert.subject = cert.issuer = OpenSSL::X509::Name.parse("/C=FOO")
cert.public_key = pkey.public_key
cert.not_before = Time.now
cert.not_after = Time.now + (365*24*60*60)
cert.sign(pkey, OpenSSL::Digest::SHA1.new)
p12 = OpenSSL::PKCS12.create("supers3cr3t", "P12 Certificate", pkey, cert)
File.open("test.p12", "w") { |s| s.write(p12.to_der) }



p12 = OpenSSL::PKCS12::PKCS12.new(File::read('test.p12'), "supers3cr3t")
puts p12.certificate
puts p12.key

File.delete("test.p12")
  end
  
end

