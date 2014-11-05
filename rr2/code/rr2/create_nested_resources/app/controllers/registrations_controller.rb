#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class RegistrationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @registration = Registration.new
  end
  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build(params[:registration])
    if @registration.save
      redirect_to root_url, :notice => "Successfully registered!"
    else
      render :new
    end
  end
  before_filter :setup_event
  def setup_event
    @event = Event.find(params[:event_id])
  end
end
