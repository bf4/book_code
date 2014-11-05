#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
class GroceryListsController < ApplicationController
  # GET /grocery_lists
  # GET /grocery_lists.xml
  def index
    @grocery_lists = GroceryList.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grocery_lists }
    end
  end

  # GET /grocery_lists/1
  # GET /grocery_lists/1.xml
  def show
    @grocery_list = GroceryList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grocery_list }
    end
  end

  # GET /grocery_lists/new
  # GET /grocery_lists/new.xml
  def new
    @grocery_list = GroceryList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grocery_list }
    end
  end

  # GET /grocery_lists/1/edit
  def edit
    @grocery_list = GroceryList.find(params[:id])
  end

  # POST /grocery_lists
  # POST /grocery_lists.xml
  def create
    @grocery_list = GroceryList.new(params[:grocery_list])

    respond_to do |format|
      if @grocery_list.save
        format.html { redirect_to(@grocery_list, :notice => 'Grocery list was successfully created.') }
        format.xml  { render :xml => @grocery_list, :status => :created, :location => @grocery_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grocery_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grocery_lists/1
  # PUT /grocery_lists/1.xml
  def update
    @grocery_list = GroceryList.find(params[:id])

    respond_to do |format|
      if @grocery_list.update_attributes(params[:grocery_list])
        format.html { redirect_to(@grocery_list, :notice => 'Grocery list was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grocery_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grocery_lists/1
  # DELETE /grocery_lists/1.xml
  def destroy
    @grocery_list = GroceryList.find(params[:id])
    @grocery_list.destroy

    respond_to do |format|
      format.html { redirect_to(grocery_lists_url) }
      format.xml  { head :ok }
    end
  end
end
