#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'blogger_api'

class BloggerService < ActionWebService::Base
  web_service_api BloggerAPI

  def initialize
    @postid = 0
  end

  def newPost(key, id, user, pw, content, publish)
    $stderr.puts "id=#{id} user=#{user} pw=#{pw}, content=#{content.inspect} [#{publish}]"
    (@postid += 1).to_s
  end

  def editPost(key, post_id, user, pw, content, publish)
    $stderr.puts "id=#{post_id} user=#{user} pw=#{pw} content=#{content.inspect} [#{publish}]"
    true
  end

  def getUsersBlogs(key, user, pw)
    $stderr.puts "getting blogs for #{user}"
    blog = Blog::Blog.new(
      :url =>'http://blog',
      :blogid => 'myblog',
      :blogName => 'My Blog'
    )
    [blog]
  end

  def getUserInfo(key, user, pw)
    $stderr.puts "getting user info for #{user}"
    Blog::User.new(:nickname => 'user', :email => 'user@test.com')
  end
end
