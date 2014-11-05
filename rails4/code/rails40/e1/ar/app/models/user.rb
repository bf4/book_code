#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
# == Schema Information
# Schema version: 20100301000016
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)     
#  hashed_password :string(255)     
#  salt            :string(255)     
#  created_at      :datetime        
#  updated_at      :datetime        
#  status          :string(255)     
#

require 'digest/sha1'

class User < ActiveRecord::Base
  
  validates_presence_of     :name
  validates_uniqueness_of   :name
 
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank
  
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  # 'password' is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  after_destroy :ensure_an_admin_remains

  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end     

private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
