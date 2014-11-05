#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Topic < ActiveRecord::Base
  has_many :replies, :foreign_key => "parent_id"
  serialize :content
  
  before_create  :default_written_on
  before_destroy :destroy_children #'self.class.delete_all "parent_id = #{id}"'

  def parent
    self.class.find(parent_id)
  end
  
  protected
    def default_written_on
      self.written_on = Time.now unless attribute_present?("written_on")
    end

    def destroy_children
      self.class.delete_all "parent_id = #{id}"
    end
end