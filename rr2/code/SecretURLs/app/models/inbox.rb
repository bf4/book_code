#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Inbox < ActiveRecord::Base 
  has_many :messages
end
class Inbox < ActiveRecord::Base 
  has_many :messages 
  before_create :generate_access_key
  def generate_access_key
    @attributes['access_key'] = MD5.hexdigest((object_id + rand(255)).to_s)
  end
end
