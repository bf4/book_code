#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  validates_presence_of :subject, :body, :commentable_id
  validates_format_of :subject, :with => /\A[a-zA-Z0-9\n\t\s,.!?\-]*\Z/ 
  validates_format_of :body, :with => /\A[a-zA-Z0-9\n\t\s,.!?\-]*\Z/   
end
