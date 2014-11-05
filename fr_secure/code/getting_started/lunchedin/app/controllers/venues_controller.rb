#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

class VenuesController < ApplicationController
  
  verify :method => :post, 
    :only => [ :create, :add_tag, :comment, :rate ],
    :redirect_to => { :action => :list }
  

  def index
    @venues = Venue.find(:all)
    
    respond_to do |format|
      format.html
    end
  end

  def new
    @venue = Venue.new
    
    respond_to do |format|
      format.html
    end    
  end

  def show
    @venue = Venue.find(params[:id])
    
    respond_to do |format|
      format.html
    end    
  end

  def create
    @venue = Venue.new(params[:venue])
    
    respond_to do |format|      
      if @venue.save
        format.html { redirect_to(@venue) }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
  def tag
    @venues = Tag.find(params[:id]).venues
    
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end
end
