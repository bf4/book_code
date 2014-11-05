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
  include Encryptor::Routines
  
  
  def test_encryptor
    @user = users(:bob)
    @user.secret_answer = 'Porsche Carrera GT'
    assert @user.save
    @answer = User.connection.select_all(
      "select secret_answer from users where id = 1"
    )
    cipher_text = @answer.first['secret_answer']
    opts = Encryptor::ActiveRecord::Encryptor.default_options
    @plain_text = decrypt(cipher_text, User.encryption_key, opts)
    assert_equal 'Porsche Carrera GT', @plain_text
  end
  

  
  test "password is hashed" do
    @user = users(:bob)
    assert_equal OpenSSL::Digest::SHA1.new('hello').hexdigest, @user.password_hash
  end
  

  
  test "authentication is successful with valid password" do
    @user = users(:bob)
    assert @user.authentic?('hello')
  end
  
  
  test "can find and authenticate bob with password hello" do
    assert User.find_and_authenticate('bob', 'hello')
  end

  
  test "authentication fails with invalid password" do
    @user = users(:bob)
    assert !@user.authentic?('hello1')
  end
  
  
  
  test "user creation should fail with weak password" do
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
