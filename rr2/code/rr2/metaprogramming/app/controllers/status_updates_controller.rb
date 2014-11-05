#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class StatusUpdatesController < ApplicationController
  search_action_for :status_updates, search_column: 'body', display_as: 'title'
  # GET /status_updates
  # GET /status_updates.xml
  def index
    @status_updates = StatusUpdate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @status_updates }
    end
  end

  # GET /status_updates/1
  # GET /status_updates/1.xml
  def show
    @status_update = StatusUpdate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status_update }
    end
  end

  # GET /status_updates/new
  # GET /status_updates/new.xml
  def new
    @status_update = StatusUpdate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status_update }
    end
  end

  # GET /status_updates/1/edit
  def edit
    @status_update = StatusUpdate.find(params[:id])
  end

  # POST /status_updates
  # POST /status_updates.xml
  def create
    @status_update = StatusUpdate.new(params[:status_update])

    respond_to do |format|
      if @status_update.save
        format.html { redirect_to(@status_update, :notice => 'Status update was successfully created.') }
        format.xml  { render :xml => @status_update, :status => :created, :location => @status_update }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status_update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /status_updates/1
  # PUT /status_updates/1.xml
  def update
    @status_update = StatusUpdate.find(params[:id])

    respond_to do |format|
      if @status_update.update_attributes(params[:status_update])
        format.html { redirect_to(@status_update, :notice => 'Status update was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status_update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /status_updates/1
  # DELETE /status_updates/1.xml
  def destroy
    @status_update = StatusUpdate.find(params[:id])
    @status_update.destroy

    respond_to do |format|
      format.html { redirect_to(status_updates_url) }
      format.xml  { head :ok }
    end
  end
end
