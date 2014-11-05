#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class RatingsController < ApplicationController

  
  def rate
    @venue = Venue.find(params[:id])
    unless @venue.has_user_rated?(session[:user_id]) 
      @venue.ratings << Rating.new do |r|
        r.score = params[:score]
        r.user_id = session[:user_id]
      end
    end
    render :partial => 'show'
  end
  
  
end
