#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"

class Comment < ActiveRecord::Base
  attr_accessor :callers

  before_validation :record_callers

  def after_validation
    record_callers
  end

  def record_callers
    callers << self.class if callers
  end
end

class CommentObserver < ActiveRecord::Observer
  attr_accessor :callers

  def after_validation(model)
    callers << self.class if callers
  end
end

class CallbacksObserversTest < ActiveRecord::TestCase
  def test_model_callbacks_fire_before_observers_are_notified
    callers = []

    comment = Comment.new
    comment.callers = callers

    CommentObserver.instance.callers = callers

    comment.valid?

    assert_equal [Comment, Comment, CommentObserver], callers, "model callbacks did not fire before observers were notified"
  end
end
