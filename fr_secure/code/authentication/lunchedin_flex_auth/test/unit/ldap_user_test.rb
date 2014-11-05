#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class LDAPUserTest < ActiveSupport::TestCase
  
  def test_find_and_authenticate_success
    assert User.find_and_authenticate('wally', "newpass1")
  end
  
  
  
  def test_create_success
    LDAPUser.ldap_server do |ldap|
      username = "test_create_username"
      lattrs = LDAPUser.build_ldap_user_hash("test","user", 
        "test@railssecurity.org", username, "password", "75093")
      # create our test user in LDAP
      dn = "uid=#{username},#{LDAP_CONF[RAILS_ENV]["basedn"]}"
      ldap.open {|l| l.add(:dn => dn, :attributes => lattrs)}
      user = LDAPUser.new do |u|
        u.username = username
        u.password = "password"
      end
      
      assert(user.save, user.errors.entries.join("\n"))
      user.reload
      # Make sure that the attributes are getting populated
      assert_equal("test@railssecurity.org", user.email)
      assert_equal("test", user.first_name)
      assert_not_nil("user", user.last_name)
      assert_equal("75093", user.zip_code)
      # This shouldn't be getting populated
      assert_nil(user.password_hash)
      assert(User.find_and_authenticate(username, "password"))
      # make sure we delete our test user afterwards
      ldap.open {|l| l.delete(:dn => dn)}
    end
  end
  
  
  
  def test_create_failure
    LDAPUser.ldap_server do |ldap|
      username = "test_create_username"
      lattrs = LDAPUser.build_ldap_user_hash("test","user",
        "test@railssecurity.org", username, "password", "75093")
      dn = "uid=#{username},#{LDAP_CONF[RAILS_ENV]["basedn"]}"
      ldap.open {|l| l.add(:dn => dn, :attributes => lattrs)}
      user = LDAPUser.new do |u|
        u.username = username
        u.password = "wrong_password"
      end
      assert(!user.save, user.errors.entries.join("\n"))
      assert(!User.find_and_authenticate(username, "password"))
      ldap.open {|l| l.delete(:dn => dn)}
    end
  end
  
  
  def test_ldap_conf_yml
    assert_not_nil(LDAP_CONF)
    assert_equal(10636, LDAP_CONF["test"]["port"], LDAP_CONF.inspect)
  end
  
end
