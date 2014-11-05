#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class EventController < ApplicationController
  
  def index
    new
    render :action => 'new'
  end
  
  def new
    @event = Event.new
  end
  
  def schedule
    @event = Event.new(:venue_id => params[:id])
  end
  
  
  def invite
    show
  end
  
  
  
  def show
    @event = Event.find(params[:id])
    unless @event.user_id == session[:user_id]  
      flash[:notice] = "Not authorized access event"
      redirect_to :action => 'index'
    end
  end
  
  
  
  def remove
    @event = Event.find(params[:id])
    if @user && @event.user_id == session[:user_id]
      @event.destroy
      render :update do |page|
        page.visual_effect :fade, "event_#{params[:id]}"
      end
    else
      flash[:notice] = "Not authorized to remove event"  
    end
  end
  
  
  def create
    @event = Event.new(params[:event])
    @event.user_id = session[:user_id]
    if @event.save
      flash[:info] = "you are almost done organizing your event!"
      redirect_to :action => 'invite', :id => @event.id
    else
      render :action => 'schedule'
    end
  end
  
  
  def finish_event
    show
    if @user && @event.user_id == session[:user_id]
      @event.status = 'Scheduled'
      @event.save
    else
      flash[:notice] = "Not authorized to finish event"
    end
    redirect_to :controller => 'profile', :action => 'my_profile'
  end
  
  
  
  def create_attendee
    @event = Event.find(params[:id])
    if @event.user_id == @user.id
      @attendee = Attendee.new(params[:attendee])
      @attendee.event_id = params[:id]
      if @attendee.save
        render :update do |page|
          page.insert_html :bottom, 'attendees', 
            :partial => 'attendee', 
            :locals => { :attendee => @attendee }
          page << "$('attendee_name').value = ''"
          page << "$('attendee_email').value = ''"
        end
      end      
    end
  end
  
  
  
  def remove_attendee
    @attendee = Attendee.find(params[:id])
    if @user && @attendee.event.user_id == session[:user_id]
      @attendee.destroy
      render :update do |page|
        page.visual_effect :fade, "attendee_#{@attendee.id}"
      end
    end
  end
  
end
