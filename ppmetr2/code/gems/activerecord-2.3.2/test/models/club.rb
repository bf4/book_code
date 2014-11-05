#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Club < ActiveRecord::Base
  has_many :memberships
  has_many :members, :through => :memberships
  has_many :current_memberships
  has_one :sponsor
  has_one :sponsored_member, :through => :sponsor, :source => :sponsorable, :source_type => "Member"

  private

  def private_method
    "I'm sorry sir, this is a *private* club, not a *pirate* club"
  end
end