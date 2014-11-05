#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
# require 'GSSAPI'
# require 'client'

class SpnegoRubyTest < ActiveSupport::TestCase
  
  def test_auto_require 
    SPNEGO::SPNEGO_E_SUCCESS
  end
  
  def test_spnego_token
    
  end
end
