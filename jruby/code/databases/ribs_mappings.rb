#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'ribs'

Ribs::DB.define do |db|
  db.dialect = 'MySQL'
  db.uri = 'jdbc:mysql://localhost:3306/using_jruby?user=root&password='
  db.driver = 'com.mysql.jdbc.Driver'
end

class Blog
  Ribs! :table => 'wp_blog',
        :identity_map => true do |blog|

    # ... mappings go here ...

    blog.blog_id.primary_key!
    blog.title :column => :blog_title


    blog.belongs_to    Owner
    blog.has_one       Layout, :name => :look
    blog.has_n         :posts

    blog.stats.avoid!
    blog.auth :avoid, :default => 'abc'
  end
end
