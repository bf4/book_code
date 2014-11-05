#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class VenuesController < ApplicationController

  def index
    @venues = Venue.find(:all)
  end

  def new
    @venue = Venue.new
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def create
    @venue = Venue.new(params[:venue])
    if @venue.save
      redirect_to venue_path(@venue)
    else
      render :action => 'new'
    end
  end
  
  def tag
    @venues = Tag.find(params[:id]).venues
    render :action => 'index'
  end
end
