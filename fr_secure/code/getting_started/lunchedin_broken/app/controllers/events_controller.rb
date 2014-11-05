#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class EventsController < ApplicationController

  def index
    new
    render :action => 'new'
  end
  
  def new
    @event = Event.new
  end
  
  
  def show
    @event = Event.find(params[:id])
  end
  
  
  def create
    @event = Event.new(params[:event])
    @event.user_id = session[:user_id]
    @event.venue_id = params[:venue_id]
    if @event.save
      flash[:info] = "you are almost done organizing your event!"
      redirect_to event_path(@event)
    else
      render :action => 'new'
    end
  end
  
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to event_path(@event)
    else
      render :action => 'show'
    end
  end
  
  
  def finished
    begin
      @event = @user.events.find(params[:id])
      @event.update_attribute(:status, 'organized')
      respond_to do |format|
        format.js
      end
    rescue
    end
  end
end
