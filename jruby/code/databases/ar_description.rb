#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'active_record'

class Blog < ActiveRecord::Base
  set_table_name 'WP_BLOG'
  set_primary_key 'blog_id'

  belongs_to :owner,     :class_name  => 'Person'
  has_one    :audit_log, :foreign_key => 'watched_id'

  has_many :posts
  has_many :authors, :through => :posts
end
