#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class CommentsController < ApplicationController
  before_filter :find_creation

  def create
    @comment = @creation.comments.new(params[:comment])
    @comment.user = current_user
    @comment.save
    redirect_to @creation
  end

  private

  def find_creation
    @creation = Creation.find(params[:creation_id])
  end
end
