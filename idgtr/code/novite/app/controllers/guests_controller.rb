#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
class GuestsController < ApplicationController
  # POST /guests
  def create
    party_permalink = params[:guest].delete :party_permalink
    party = Party.find_by_permalink party_permalink
    @guest = Guest.new(params[:guest].merge :party_id => party.id)

    if @guest.save
      redirect_to @guest.party, :notice => 'You have successfully RSVPed.'
    else
      redirect_to @guest.party
    end
  end
end
