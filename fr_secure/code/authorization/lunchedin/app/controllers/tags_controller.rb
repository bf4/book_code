#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class TagsController < ApplicationController

  def create
    @venue = Venue.find(params[:venue_id])
    respond_to do |format|
      if @venue.tag(params[:tag])
        format.js do
          render :update do |page|
            page.replace_html 'tags_show', :partial => 'show', :locals => { :tags => @venue.tags }
            page['new_tag'].clear
          end
        end
      end
    end
  end
  
end
