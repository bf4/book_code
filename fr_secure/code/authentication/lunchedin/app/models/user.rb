#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
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
  
  
  def authentic?(p)
    password_hash == 
      hashed_and_salted_password(p,salt)
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
  
  
  
  def hashed_and_salted_password(p, s)
    OpenSSL::Digest::SHA1.new([s,p].to_s).hexdigest
  end
  
  
end
