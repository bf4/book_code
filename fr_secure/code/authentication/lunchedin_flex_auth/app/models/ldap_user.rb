#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'net/ldap'


class LDAPUser < User
  attr_accessor :password, :password_confirmation  
  
  def authentic?(p)
    ldap = Net::LDAP::new({ 
      :host => "localhost", 
      :port => 10636, 
      :auth => {
        :method => :simple, 
        :username =>
        "uid=#{username},#{LDAP_CONF[RAILS_ENV]["basedn"]}",
        :password => p
      },
      :encryption => :simple_tls
    })
    bind = ldap.bind
  end
  
  
  
  before_save :hydrate_values_from_ldap
    
  def hydrate_values_from_ldap
    LDAPUser.ldap_server do |ldap|
      results = ldap.search({
        :base   => LDAP_CONF[RAILS_ENV]["basedn"],
        :filter => Net::LDAP::Filter.eq( "uid", username)})
      raise "Ambiguous LDAP search.  " if results.size > 1
      write_attribute(:email, results[0].mail[0])
      write_attribute(:zip_code, results[0].postalCode[0])
      write_attribute(:first_name, results[0].givenName[0])
      write_attribute(:last_name,  results[0].sn[0])
    end
  end
  
  
  
  def validate
    unless authentic?(password)
      errors.add_to_base("LDAP Authentication failed")
    end
  end
  
  
  
  def self.build_ldap_user_hash(first_name, last_name, 
    email, username, password, zip_code)
    lattrs = {
      :cn => "#{first_name} #{last_name}",
      :givenName => first_name,
      :objectclass => 
        ["inetOrgPerson", "organizationalPerson", 
         "person","top"],
      :sn   => last_name,
      :uid  => username,
      :mail => email,
      :postalCode => zip_code,
      :userPassword => ldap_ssha(password)
    }
  end
  
  
  def self.ldap_server(conf = LDAP_CONF[RAILS_ENV], &block)
    ldap = Net::LDAP.new({:host => conf["host"],
      :port => conf["port"], 
        :auth => {
          :method   => conf["auth"]["method"].to_sym, 
          :username => conf["auth"]["username"], 
          :password => conf["auth"]["password"]
          },
        :encryption => conf["encryption"].to_sym}) 
    yield(ldap)
    ldap
  end
  
  
  def self.ldap_ssha(password)
    salt_byte_data = OpenSSL::Random.random_bytes(8)
    sha1_digest = Digest::SHA1.digest(password + salt_byte_data)
    pwd_sha1_bs_sa_bs = Base64::encode64(sha1_digest + salt_byte_data)
    "{SSHA}#{pwd_sha1_bs_sa_bs}"
  end
  
end
