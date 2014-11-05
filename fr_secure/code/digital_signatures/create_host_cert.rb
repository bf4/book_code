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

File.open("host.cert1", "w") do |f|
  private_key = OpenSSL::PKey::RSA.new(File::read('host.key'))
  cert = OpenSSL::X509::Certificate.new
  cert.subject = OpenSSL::X509::Name.new('/CN=')
  cert.not_before = Time.now
  cert.not_after = Time.now + 365 * 24 * 60 * 60
  cert.public_key = private_key.public_key
  cert.serial = 3
  cert.version = 2
  cert.sign(private_key, OpenSSL::Digest::SHA1.new)
  f.write(cert)
end