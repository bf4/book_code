#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Friendship < ActiveRecord::Base
  belongs_to :person
  belongs_to :friend, :class_name => "Person"
end
class Friendship < ActiveRecord::Base
  belongs_to :person
  belongs_to :friend, :class_name => "Person"
  after_create :be_friendly_to_friend
  after_destroy :no_more_mr_nice_guy

  def be_friendly_to_friend
    friend.friends << person unless friend.friends.include?(person)
  end
  def no_more_mr_nice_guy
    friend.friends.delete(person)
  end
end
