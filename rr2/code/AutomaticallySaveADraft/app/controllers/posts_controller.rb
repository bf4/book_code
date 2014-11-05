#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class PostsController < ApplicationController
  def save_draft
    session[:post_draft] = Post.new(params[:post])
    render :text => "<i>draft saved at #{Time.now}</i>"
  end
  def new
    if request.get?
      @post = session[:post_draft] || Post.new
    else 
      @post = Post.create(params[:post])
      session[:post_draft] = nil
      redirect_to :action => 'list'
    end
  end
end
