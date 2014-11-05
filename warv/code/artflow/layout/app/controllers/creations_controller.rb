#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class CreationsController < ApplicationController
  def index
    @creations = Creation.all
  end

  def show
    @creation = Creation.find(params[:id])
  end

  def create
    @creation = Creation.new(params[:creation])
    if @creation.save
      flash[:notice] = "Creation added!"
      redirect_to @creation
    else
      flash.now[:alert] = "Could not save creation!"
      render action: 'new'
    end
  end

  def permissions
    @creation = Creation.find(params[:id])
  end

end
