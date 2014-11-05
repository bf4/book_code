#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'openid/consumer'
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
    write_attribute(:password_hash, 
      OpenSSL::Digest::SHA1.new(password).hexdigest)
  end
  
  def password
    @password
  end
    
  
  def authentic?(p)
    password_hash == OpenSSL::Digest::SHA1.new(p).hexdigest
  end
  
  
  
  def self.find_and_authenticate(username, password)
    user = User.find_by_username(username)
    return false if user.nil?
    if user.authentic?(password)
      user
    else
      false
    end
  end
  
  
  
  def self.create_from_openid_data(identifier, openid_data)
    user = User.new do |u|
      u.first_name = openid_data['fullname'].split(' ').first
      u.last_name  = openid_data['fullname'].split(' ').last
      u.email      = openid_data['email']
      # Just create a random password
      rand_data = OpenSSL::Random.random_bytes(255)
      u.password_hash = OpenSSL::Digest::SHA1.new(rand_data).hexdigest
      u.username   = identifier
      u.zip_code   = openid_data['postcode']
    end
    # We are going to skip validation for this kind of creation.
    user.save(false)
    user
  end
  
  
end
