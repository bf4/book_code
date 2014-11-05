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
require 'rubygems'
require_gem 'activesupport'
require 'breakpoint'


require 'openssl'



class DhBnTest < Test::Unit::TestCase
  
  def test_dh
   
   
   # alice and bob's dh params
   alice, bob = OpenSSL::PKey::DH.generate(512), OpenSSL::PKey::DH.generate(512) 
            
   # let the key exchange begin!
   alice_calc_secret = alice.compute_key(OpenSSL::BN.new(bob.public_key.to_s)) 
   bob_calc_secret = bob.compute_key(OpenSSL::BN.new(alice.public_key.to_s))
      
   p "Bob's Public Key:  #{bob.pub_key}"
   p "Alice's Public Key:  #{alice.pub_key}"   
   
   p "Alice's Computed Key #{alice_calc_secret}"
   p "Bob's Computed Key #{bob_calc_secret}"
   
   
   
   assert alice_calc_secret == bob_calc_secret
    
  end
  
  
end
    
