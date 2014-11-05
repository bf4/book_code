#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :special_posts, :class_name => "Post"
  has_and_belongs_to_many :hello_posts, :class_name => "Post", :conditions => "\#{aliased_table_name}.body = 'hello'"
  has_and_belongs_to_many :nonexistent_posts, :class_name => "Post", :conditions=>"\#{aliased_table_name}.body = 'nonexistent'"
  
  def self.what_are_you
    'a category...'
  end
  
  has_many :categorizations
  has_many :authors, :through => :categorizations, :select => 'authors.*, categorizations.post_id'
end

class SpecialCategory < Category
  
  def self.what_are_you
    'a special category...'
  end  
  
end
