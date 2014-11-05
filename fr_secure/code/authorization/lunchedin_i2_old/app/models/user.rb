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
  validates_presence_of :email, :first_name, :last_name, :user_name, :password
  validates_uniqueness_of :user_name
  validates_length_of :zip_code, :is => 5
  validates_numericality_of :zip_code
  validates_confirmation_of :password
  has_many :events
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :role
  
  
  def before_save
    self.salt = 
      self.salt.nil? || self.salt.length == 0 ? Base64.encode64(OpenSSL::Random.random_bytes(256)) : self.salt 
    self.password = 
      Digest::SHA1.hexdigest("#{self.salt}#{self.password}") 
  end
  
  
end
