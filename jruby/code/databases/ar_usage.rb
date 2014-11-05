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

b1 = Blog.new :author => 'Ola Bini'
b1.title = 'My first blog'
b1.save

Blog.create :title => 'My second blog'

b2 = Blog.find(2)
b2.title = 'My second blog, revisited'
b2.posts.create(:title => 'First post',
                :body  => 'This is a post about something')
b2.save

my_blogs = Blog.where(:author => 'Ola Bini')
my_blogs.first.destroy
