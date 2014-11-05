#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'


class RoleBasedController < ApplicationController
  roles :admin
  def admin_only
    
  end
  
  roles :admin, :user
  def user_and_admin
    
  end
end



class RoleBasedControllerAuthorizationTest < Test::Unit::TestCase
  def test_admin_only
    assert(RoleBasedController.access_list[:admin_only] == [:admin])
    assert(RoleBasedController.access_list[:user_and_admin] == [:admin, :user])
  end
end

