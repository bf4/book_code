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


class HmacTest < Test::Unit::TestCase

  def test_hmac_success
    

    key = 'this is my key'
    patron_hmac = OpenSSL::HMAC.new(key, OpenSSL::Digest::SHA1.new)
    patron_hmac << "I would like a beer"
    req = patron_hmac.hexdigest
    
    # bar maiden determines authenticity of the request
    
  end
  
  
  def test_hmac_success_with_nonce
    key = 'new key'
    patron_hmac = OpenSSL::HMAC.new(key, OpenSSL::Digest::SHA1.new)
    patron_hmac << "get me a beer"
    patron_hmac << Time.now.to_s
    req = patron_hmac.hexdigest
    
    
  end  
  
end