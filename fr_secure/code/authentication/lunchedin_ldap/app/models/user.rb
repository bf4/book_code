#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
gem 'ruby-net-ldap'
require 'net/ldap'

class User < ActiveRecord::Base
  attr_protected :role_id 
  validates_presence_of :email, :first_name, :last_name
  validates_presence_of :username, :password_hash
  validates_uniqueness_of :username
  validates_length_of :zip_code, :is => 5
  validates_length_of :password, :in => 7..32
  validates_numericality_of :zip_code
  validates_confirmation_of :password
  has_many :events
  has_many :comments, :as => :commentable
  belongs_to :role
  
  def password=(password)
    @password = password
    write_attribute(:salt,
      OpenSSL::Digest::SHA1.new(
        OpenSSL::Random.random_bytes(256)).hexdigest)
    write_attribute(:password_hash, 
      hashed_and_salted_password(password, salt))  
  end
    
  def password
    @password
  end
  
  
  
  if AUTHENTICATION_MECHANISM == "ldap"
    
    
    before_save :create_in_ldap
    
    
    
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
    
  else
    def authentic?(p)
      password_hash == 
        hashed_and_salted_password(p,salt)
    end
  end
  
  
  
  def self.find_and_authenticate(username, password)
    user = User.find_by_username(username)
    return false if user.nil?

    if user.authentic?(password)
      return user
    end
    
    false
  end
  

  
  def create_in_ldap
    User.ldap_server do |ldap|
      lattrs = {
        :cn => "#{first_name} #{last_name}",
        :objectclass => 
          ["inetOrgPerson", "organizationalPerson", 
           "person","top"],
        :sn   => "#{last_name}",
        :uid  => "#{username}",
        :mail => "#{email}",
        :userPassword => User.ldap_ssha(@password)
      }
      
      dn = "uid=#{username},#{LDAP_CONF[RAILS_ENV]["basedn"]}"
      ldap.open {|l| l.add(:dn => dn, :attributes => lattrs)}
    end
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
  
  
  def hashed_and_salted_password(p, s)
    OpenSSL::Digest::SHA1.new([s,p].to_s).hexdigest
  end
  
end
