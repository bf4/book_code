#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Meeting < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  has_many :attendances
  has_many :attendees, 
           :through => :attendances, 
           :source => :person
  def to_s
    "#{subject} - #{pluralize(attendees.count, 'person')} attending"
  end
end
