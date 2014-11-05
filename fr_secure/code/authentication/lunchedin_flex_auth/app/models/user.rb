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
  validates_presence_of :username
  validates_uniqueness_of :username
  has_many :events
  has_many :comments, :as => :commentable
  belongs_to :role
  
  def self.find_and_authenticate(username, password)
    user = find_by_username(username)
    return false if user.nil?
    if user.authentic?(password)
      return user
    end
    false
  end
  
end
