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
  TEST_ACTIVE_DIRECTORY = false
  
  
  def test_find_and_authenticate_success
    assert User.find_and_authenticate('wally', "newpass1")
  end
  
  
  
  def test_authentic_failed
    assert !User.find_and_authenticate('wally', 'foo')
  end
  
  
  
  def test_authentic
    assert users(:wally).authentic?("newpass1")
  end
  
  
  if TEST_ACTIVE_DIRECTORY
  
  def test_active_directory_domain_name_success
    ldap = Net::LDAP::new({
      :host => "192.168.137.10",
      :port => 389,
      :auth => {
        :method   => :simple,
        :username =>
          'RAILSSECURITY\\draphael',
        :password => "RailsIs5uper"
        }
      })
    assert ldap.bind
  end
  
  
  
  def test_active_directory_domain_name_failure
    ldap = Net::LDAP::new({ 
      :host => "192.168.137.10", 
      :port => 389, 
      :auth => {
        :method   => :simple, 
        :username =>
          'RAILSSECURITY\\foobar',
        :password => "foobar"
        }
      })
    assert !ldap.bind
  end
  
  
  
  def test_active_directory_ldap_name
    ldap = Net::LDAP::new({ 
      :host => "192.168.137.10",
      :port => 389, 
      :auth => {
        :method => :simple, 
        :username =>
          'cn=David Raphael,CN=Users,dc=railssecurity,dc=org',
        :password => "RailsIs5uper"
        }
      })
    assert ldap.bind
  end
  
  end

  
  def test_ldap_conf_yml
    assert_not_nil(LDAP_CONF)
    assert_equal(10636, LDAP_CONF["test"]["port"], LDAP_CONF.inspect)
  end
  
  
  
  def test_ldap_server_with_plain_password
    username = 'bldap'
    plaintext = 'newpass1'
    lattrs = {
      :cn => "Bob",
      :objectclass => 
        ["inetOrgPerson", "organizationalPerson", 
         "person","top"],
      :sn   => "LDAPguy",
      :uid  => username,
      :mail => "bob@railssecurity.org",
      :userPassword => plaintext
    }
    
    dn = "uid=#{username},#{LDAP_CONF[RAILS_ENV]["basedn"]}"
    User.ldap_server do |ldap|
      ldap.open {|l| l.add(:dn => dn, :attributes => lattrs)}
      assert User.find_and_authenticate(username, plaintext)
      ldap.open {|l| l.delete(:dn => dn)}
    end
  end
  
  
  
  def test_ldap_server_with_ssha_password
    username = 'bldap'
    plaintext = 'newpass1'
    password = User.ldap_ssha(plaintext)
    lattrs = {
      :cn => "Bob",
      :objectclass => 
        ["inetOrgPerson", "organizationalPerson", 
         "person","top"],
      :sn   => "LDAPguy",
      :uid  => username,
      :mail => "bob@railssecurity.org",
      :userPassword => password
    }
    dn = "uid=#{username},#{LDAP_CONF[RAILS_ENV]["basedn"]}"    
    User.ldap_server do |ldap|
      ldap.open {|l| l.add(:dn => dn, :attributes => lattrs)}
      assert User.find_and_authenticate(username, plaintext)
      ldap.open {|l| l.delete(:dn => dn)}
    end
  end
  
  
  
  def test_create_in_db_and_ldap
    attrs = {
      :username        => "bjoe",
      :email           => "bobby@railssecurity.org",
      :password        => "bobby's secret!",
      :first_name      => "bobby",
      :last_name       => "joe",
      :zip_code        => "75123"
    }
    user = User.new(attrs)
    assert(user.save, user.errors.entries.join("\n"))
    assert User.find_and_authenticate(attrs[:username],attrs[:password] )
    
    User.ldap_server do |ldap|
      dn = "uid=#{attrs[:username]},#{LDAP_CONF[RAILS_ENV]["basedn"]}"
      ldap.open {|l| l.delete(:dn => dn)}
      assert(!User.find_and_authenticate(attrs[:username], attrs[:password]))
    end
  end
  

end
