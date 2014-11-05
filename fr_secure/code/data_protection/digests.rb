#!/usr/bin/env ruby
#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

require 'openssl'

%w(DSS1 MD2 MD4 MD5 MDC2 RIPEMD160 SHA SHA1).each do |digest|
  h = eval("OpenSSL::Digest::#{digest}.new('chunky bacon')").hexdigest
  puts "#{digest}: #{h}"
end
