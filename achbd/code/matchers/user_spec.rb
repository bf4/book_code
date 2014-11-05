#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec'

class User
  class << self
    def users
      @users ||= []
    end
    
    def find(username)
      #bogus implementation to create a different object
      #with the same username
      User.new(username)
    end
  end
  
  attr_reader :username
  attr_reader :roles
  def initialize(username)
    self.class.users << self
    @username = username
    @roles = []
  end
  
  def add_role(role)
    roles << role
  end

  def in_role?(role)
    @roles.include?(role)
  end
end

context "User" do
  
  specify "should be in role after adding role" do
    user = User.new("username")
    user.add_role(:editor)
    user.should be_in_role(:editor)
  end
  
  specify "should see changes in Roles implemented on other instances" do
    user = User.new("username")
    copy = User.find("username")
    user.add_role(:editor)
    copy.should be_in_role(:editor)
  end
  
end
