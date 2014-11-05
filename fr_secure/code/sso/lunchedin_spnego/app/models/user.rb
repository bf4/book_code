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
  
  
  
  # This is not the ideal implementation
  # You will have to adapt this to your needs
  def self.create_or_find_from_kerb_princ(kerb_princ)
    user = find_by_username(kerb_princ)
    unless user
      user = User.new do |u|
        u.username   = kerb_princ
        u.email      = "(email)"
        u.first_name = "(first_name)"
        u.last_name  = "(last_name)"
        u.zip_code   = "75093"
      end
      user.save(false)
    end
    user
  end
  
end
