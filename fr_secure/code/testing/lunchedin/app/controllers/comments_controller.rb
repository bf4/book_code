#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CommentsController < ApplicationController

  before_filter :check_authorization, :only => [:destroy]

  def destroy
    Comment.delete(params[:id])
    respond_to do |format|
      format.js do
        render :update do |page| 
          page.visual_effect :fade, "comment_#{params[:id]}"
        end
      end
    end
  end

  def create
    @venue = Venue.find(params[:venue_id])
    @comment = @venue.comments.create(params[:comment].merge({:user_id => session[:user_id]}))
    respond_to do |format|
      format.html { redirect_to venue_path(params[:venue_id]) }
      format.js do
        render :update do |page|
          if @comment.valid?
            page.insert_html :bottom, 'comments', :partial => 'comment', 
              :locals => {:comment => @comment}
            page.visual_effect :highlight, "comment_#{@comment.id}"
            page['comment_subject'].clear
            page['comment_body'].clear
          end
        end
      end
    end
  end
  
  protected
  
  # TODO test this this check_auth method against chapter content
  def check_authorization
    unless @authenticated_user and @authenticated_user.role.name == 'admin'
      flash[:notice] = "Not authorized!"
      redirect_to root_path
    end
  end
end
