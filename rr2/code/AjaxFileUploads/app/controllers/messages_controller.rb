#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class MessagesController < ApplicationController
  upload_status_for :save
  def custom_status
   render :inline => "<%= upload_progress.completed_percent rescue 0 %> % complete", :layout => false
  end      

  def save
#    File.open(File.join(
#                RAILS_ROOT, 
#                "public", 
#                "images", 
#                params[:picture].original_filename), 
#              "wb") do |f|
#      f.write(params[:picture].read)
#    end               
                        
  end
  def new
    @message = Message.new
  end     
end