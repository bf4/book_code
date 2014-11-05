#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'openssl'

class UserTest < Test::Unit::TestCase
  fixtures :users

  # Replace this with your real tests.
  def test_create
    num_users = User.count
    
    @user = User.create :email => 'test@yahoo.com', :password => 'password'
    
    assert_equal num_users + 1, 2
  end
  
  def test_before_create
    @user = User.new(:email => 'test@yahoo.com', :password => 'asdf')
    assert_equal @user.password, 'asdf'
    @user.save
    assert_equal @user.authenticate('asdf'), true
    assert_equal @user.password, OpenSSL::Digest::SHA1.new('asdf').hexdigest
  end
  
end
