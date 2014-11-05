#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
#---
require "data_mapper"
class Bookmark
  include DataMapper::Resource
  property :id, Serial
  property :url, String, :required => true, :format => :url
  property :title, String, :required => true
  # Add tag support
  has n, :taggings, :constraint => :destroy
  has n, :tags, :through => :taggings, :order => [:label.asc]
  def tagList
    tags.collect do |tag|
      tag.label
    end
  end
end
