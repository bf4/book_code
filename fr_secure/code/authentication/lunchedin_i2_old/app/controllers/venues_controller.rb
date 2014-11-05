#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

class VenuesController < ApplicationController
  
  verify :method => :post, 
    :only => [ :create, :add_tag, :comment, :rate ],
    :redirect_to => { :action => :list }
  
  
  def index
    redirect_to :action => 'search'
  end
  
  def browse
    redirect_to :action => 'list'
  end
  
  def query
    # for now
    @venues = Venue.find :all
    render :action => 'list'
  end
  
  def list
    @venues = Venue.find(:all)
  end
  
  def show
    @venue = Venue.find(params[:id])
  end
  
  def new
    @venue = Venue.new
  end
  
  def create
    @venue = Venue.new(params[:venue])
    if @venue.save
      flash[:notice] = 'a new destination was successfully created.'
      redirect_to :action => 'show', :id => @venue.id
    else
      render :action => 'new'
    end
  end  
  
  def tag
    @venues = Venue.find_tagged_with(params[:id])
    render :action => 'list'
  end

  def add_tag
    @venue = Venue.find(params[:id])
    if @venue && @venue.add_tag(params[:tag])
      render :update do |page| 
        page.replace_html 'tag-cloud', :partial => 'shared/tag_cloud', 
          :locals => { :tags => @venue.tags }
        page << "$('tag-text-field').value = ''"
      end
    end
  end
  
  def comment
    @venue = Venue.find(params[:id])
    @comment = Comment.new(params[:comment])
    @comment.user_id = session[:user_id]
    if @venue && @venue.comments << @comment
      render :update do |page| 
        page.insert_html :bottom, 'comments', :partial => 'comment'
        page.visual_effect :highlight, "comment_#{@comment.id}"
        page << "$('comment_subject').value = ''"
        page << "$('comment_body').value = ''"        
      end
    end
  end

  
  def rate
    @venue = Venue.find(params[:id])
    unless @venue.has_user_rated?(session[:user_id]) 
      @venue.ratings << Rating.new do |r|
        r.score = params[:score]
        r.user_id = session[:user_id]
      end
    end
    render :text => approval_rating(@venue)
  end
  
  
  private
  
  # this class method exposes it in the helper
  helper_method :approval_rating
  def approval_rating(venue)
    "#{sprintf('%d', venue.rating * 100)}% approval from #{venue.ratings_count} people"
  end  
end
