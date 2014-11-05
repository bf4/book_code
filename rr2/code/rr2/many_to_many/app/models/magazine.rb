#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Magazine < ActiveRecord::Base
  has_many :subscriptions
  has_many :readers, :through => :subscriptions       
end
class Magazine < ActiveRecord::Base
  has_many :semiannual_subscribers, 
           :through => :subscriptions, 
           :source => :reader,
           :conditions => ["length_in_issues = 6"]
end
