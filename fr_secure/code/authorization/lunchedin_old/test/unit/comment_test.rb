#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :comments

  
  def test_save
    comment = Comment.new do |c|
     c.subject = "Finally, a comment with-out markup!"
     c.body = "this is a comment that should work..no?"
     c.commentable_id = 1
    end
    assert comment.save    
  end
  
  
  
  def test_save_fails
    comment = Comment.new do |c|
     c.subject = "Comment with markup <br/>"
     c.body = "hacked! <script>alert('hello');</script>"
     c.commentable_id = 1
    end
    assert_equal false, comment.save
    assert_equal 2, comment.errors.length
  end
  
end
