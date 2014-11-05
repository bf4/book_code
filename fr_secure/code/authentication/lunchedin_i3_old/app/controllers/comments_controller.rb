#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CommentsController < ApplicationController
  
  before_filter :check_authorization
  
  def check_authorization
    unless @user and @user.role.name == 'admin'
      flash[:notice] = "Not authorized!"
      redirect_to :controller => 'root', :action => 'index'
    end
  end
  
  def remove
    Comment.delete(params[:id])
    render :update do |page| 
      page.visual_effect :fade, "comment_#{params[:id]}"
    end
  end
    
end
