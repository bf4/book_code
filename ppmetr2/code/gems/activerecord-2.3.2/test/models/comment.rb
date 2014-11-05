#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Comment < ActiveRecord::Base
  named_scope :containing_the_letter_e, :conditions => "comments.body LIKE '%e%'"
  
  belongs_to :post, :counter_cache => true

  def self.what_are_you
    'a comment...'
  end

  def self.search_by_type(q)
    self.find(:all, :conditions => ["#{QUOTED_TYPE} = ?", q])
  end
end

class SpecialComment < Comment
  def self.what_are_you
    'a special comment...'
  end
end

class VerySpecialComment < Comment
  def self.what_are_you
    'a very special comment...'
  end
end
