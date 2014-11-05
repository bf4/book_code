#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class RemindersController < ApplicationController
  def index
    @reminders = Reminder.all.select do |reminder|
      reminder.expired?
    end
  end
def index
  require 'ruby-debug';debugger
  @reminders = Reminder.all.select do |reminder|
    reminder.expired?
  end
end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/new
  # GET /reminders/new.json
  def new
    @reminder = Reminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    @reminder = Reminder.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.json
  def create
    @reminder = Reminder.new(params[:reminder])

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render json: @reminder, status: :created, location: @reminder }
      else
        format.html { render action: "new" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.json
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url }
      format.json { head :ok }
    end
  end
end
