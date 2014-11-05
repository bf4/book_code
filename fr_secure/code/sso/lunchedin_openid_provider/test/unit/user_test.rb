#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  
  def test_password_is_hashed
    @user = users(:bob)
    assert_equal OpenSSL::Digest::SHA1.new('hello').hexdigest, @user.password_hash
  end
  

  
  def test_authenticate_success
    @user = users(:bob)
    assert @user.authentic?('hello')
  end
  
  
  def test_find_and_authenticate_success
    assert User.find_and_authenticate('bob', 'hello')
  end

  
  def test_authentic_failed
    @user = users(:bob)
    assert !@user.authentic?('hello1')
  end
  
  
  
  def test_create_user_with_weak_password
    @user = User.new do |u|
      u.first_name = 'Bob'
      u.last_name = 'Smith'
      u.password = 'short'
      u.password_confirmation = 'short'
      u.email = 'bob@somedomain.com'
      u.username = 'bsmith'
      u.zip_code = '75024'
    end
    assert !@user.save
  end
  
  
end
