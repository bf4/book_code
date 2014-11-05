#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class GuideController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def comment_on_restaurant
    @restaurant = Restaurant.find(params[:id])
    @restaurant.comments.create params[:comment]
    @comment = Comment.new

    flash[:notice] = 'Comment created'
    render :action => 'show'
  end

  def review
    @review = Review.find(params[:id])
    @comment = Comment.new
  end

  def comment_on_review
    @review = Review.find(params[:id])
    @review.comments.create params[:comment]
    @comment = Comment.new

    flash[:notice] = 'Comment created'
    render :action => 'review'
  end
end
