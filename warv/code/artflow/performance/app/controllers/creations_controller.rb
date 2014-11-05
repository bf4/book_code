#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class CreationsController < ApplicationController

  before_filter :authenticate_user!
  caches_action :index

  def index
    @creations = current_user.creations
  end


  def new
    @creation = Creation.new
  end
    
  def show
    @creation = Creation.find(params[:id])
    @client = @creation.project.client
    respond_to do |format|
      format.json do
        render :json => CreationSummary.new(@creation, current_user).to_json
      end
      format.html
    end
  end

  def edit
    @creation = Creation.find(params[:id])
  end

  def update
    @creation = Creation.find(params[:id])
    if @creation.update_attributs(params[:creation])
      redirect_to @creation
    else
      render action: 'edit'
    end
  end

  def create
    @creation = current_project.creations.new(params[:creation])
    if @creation.save
      expire_action action: :index
      flash[:notice] = "Creation added!"
      redirect_to @creation
    else
      flash.now[:alert] = "Could not save creation!"
      render action: 'new'
    end
  end

  def permissions
    @creation = Creation.find(params[:id])
  end

  private

  def current_project
    # Not implemented
  end

end
