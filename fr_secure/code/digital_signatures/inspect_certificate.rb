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
include OpenSSL::X509

# inspect the certificate
cert = Certificate.new(File.read("host.cert"))
puts "Subject:      #{cert.subject}"
puts "Algorithm:    #{cert.signature_algorithm}"
puts "Serial:       #{cert.serial}"
puts "Not Before:   #{cert.not_before}"
puts "Not After:    #{cert.not_after}"
puts "#{cert.public_key.to_pem}"
