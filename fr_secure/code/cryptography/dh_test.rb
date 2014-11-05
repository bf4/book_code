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



class DhTest < Test::Unit::TestCase
  
  def test_dh
   
   
   p = 47
   g = 5
   
   # alice's dh params
   alice = OpenSSL::PKey::DH.new 
   alice.p = p 
   alice.g = g 
   alice.priv_key = 4 
   
   # generate alice's public and private secret   
   alice.generate_key! 
   
   # bob's dh params
   bob = OpenSSL::PKey::DH.new
   bob.p = p
   bob.g = g
   bob.priv_key = 3
   
   # generate bob's public and private secret   
   bob.generate_key!
   
   # let the key exchange begin!
   alice_calc_secret = alice.compute_key(bob.pub_key).unpack('C') 
   bob_calc_secret = bob.compute_key(alice.pub_key).unpack('C')
      
   puts "Bob's Public Key:  #{bob.pub_key}"
   puts "Alice's Public Key:  #{alice.pub_key}"   
   
   puts "Alice's Computed Key #{alice_calc_secret}"
   puts "Bob's Computed Key #{bob_calc_secret}"
   
   
   
   assert alice_calc_secret == bob_calc_secret
    
  end
  
  
end
    
    