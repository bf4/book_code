#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class AttendeesController < ApplicationController

  
  def create
    begin
      @event = @authenticated_user.events.find(params[:event_id])
      if @attendee = @event.attendees.create(params[:attendee])
        respond_to do |format|
          format.js
        end
      end
    rescue
      render :nothing => true
    end
  end
  
  
  
  def destroy
    @attendee = @authenticated_user.events.find(params[:event_id]).
      attendees.find(params[:id])
    if @attendee.destroy
      respond_to do |format|
        format.js do
          render :update do |page|
            page.visual_effect :fade, "attendee_#{params[:id]}"
          end      
        end
      end
    end
  end
  

end
