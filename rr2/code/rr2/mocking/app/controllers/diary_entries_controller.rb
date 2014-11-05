#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class DiaryEntriesController < ApplicationController
  # GET /diary_entries
  # GET /diary_entries.json
  def index
    @diary_entries = DiaryEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @diary_entries }
    end
  end

  # GET /diary_entries/1
  # GET /diary_entries/1.json
  def show
    @diary_entry = DiaryEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @diary_entry }
    end
  end

  # GET /diary_entries/new
  # GET /diary_entries/new.json
  def new
    @diary_entry = DiaryEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @diary_entry }
    end
  end

  # GET /diary_entries/1/edit
  def edit
    @diary_entry = DiaryEntry.find(params[:id])
  end

  # POST /diary_entries
  # POST /diary_entries.json
  def create
    @diary_entry = DiaryEntry.new(params[:diary_entry])
	
    respond_to do |format|
      if @diary_entry.save
        format.html { redirect_to @diary_entry,
                        :notice => 'Diary entry was successfully created.' }
        format.json { render :json => @diary_entry,
                        :status => :created,
                        :location => @diary_entry }
      else
        format.html { render :action => "new" }
        format.json { render :json => @diary_entry.errors,
                        :status => :unprocessable_entity }
      end
    end
  end
  # PUT /diary_entries/1
  # PUT /diary_entries/1.json
  def update
    @diary_entry = DiaryEntry.find(params[:id])

    respond_to do |format|
      if @diary_entry.update_attributes(params[:diary_entry])
        format.html { redirect_to @diary_entry, :notice => 'Diary entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @diary_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diary_entries/1
  # DELETE /diary_entries/1.json
  def destroy
    @diary_entry = DiaryEntry.find(params[:id])
    @diary_entry.destroy

    respond_to do |format|
      format.html { redirect_to diary_entries_url }
      format.json { head :ok }
    end
  end
end
