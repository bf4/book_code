#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Member < ActiveRecord::Base
  has_one :current_membership
  has_many :memberships
  has_many :fellow_members, :through => :club, :source => :members
  has_one :club, :through => :current_membership
  has_one :favourite_club, :through => :memberships, :conditions => ["memberships.favourite = ?", true], :source => :club
  has_one :sponsor, :as => :sponsorable
  has_one :sponsor_club, :through => :sponsor
  has_one :member_detail
  has_one :organization, :through => :member_detail
  belongs_to :member_type
end