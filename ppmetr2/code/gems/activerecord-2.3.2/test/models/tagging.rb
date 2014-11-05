#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# test that attr_readonly isn't called on the :taggable polymorphic association
module Taggable
end

class Tagging < ActiveRecord::Base
  belongs_to :tag, :include => :tagging
  belongs_to :super_tag,   :class_name => 'Tag', :foreign_key => 'super_tag_id'
  belongs_to :invalid_tag, :class_name => 'Tag', :foreign_key => 'tag_id'
  belongs_to :taggable, :polymorphic => true, :counter_cache => true
end