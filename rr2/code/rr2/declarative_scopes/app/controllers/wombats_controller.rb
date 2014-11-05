#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class WombatsController < ApplicationController
  def search
    @wombats = Wombat.where("bio like ?", "%#{params[:q]}%").
                      order(:age)
    render :index
  end

  def search
    @wombats = Wombat.with_bio_containing(params[:q])
    render :index
  end

  # GET /wombats
  # GET /wombats.xml
  def index
    @wombats = Wombat.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wombats }
    end
  end

  # GET /wombats/1
  # GET /wombats/1.xml
  def show
    @wombat = Wombat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wombat }
    end
  end

  # GET /wombats/new
  # GET /wombats/new.xml
  def new
    @wombat = Wombat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wombat }
    end
  end

  # GET /wombats/1/edit
  def edit
    @wombat = Wombat.find(params[:id])
  end

  # POST /wombats
  # POST /wombats.xml
  def create
    @wombat = Wombat.new(params[:wombat])

    respond_to do |format|
      if @wombat.save
        format.html { redirect_to(@wombat, :notice => 'Wombat was successfully created.') }
        format.xml  { render :xml => @wombat, :status => :created, :location => @wombat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wombat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wombats/1
  # PUT /wombats/1.xml
  def update
    @wombat = Wombat.find(params[:id])

    respond_to do |format|
      if @wombat.update_attributes(params[:wombat])
        format.html { redirect_to(@wombat, :notice => 'Wombat was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wombat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wombats/1
  # DELETE /wombats/1.xml
  def destroy
    @wombat = Wombat.find(params[:id])
    @wombat.destroy

    respond_to do |format|
      format.html { redirect_to(wombats_url) }
      format.xml  { head :ok }
    end
  end
end
