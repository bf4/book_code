#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class PeopleController < ApplicationController
  cache_sweeper :audit_sweeper 
  def index
    list
    render :action => 'list'
  end

  def list
    @person_pages, @people = paginate :people, :per_page => 10
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice] = 'Person was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash[:notice] = 'Person was successfully updated.'
      redirect_to :action => 'show', :id => @person
    else
      render :action => 'edit'
    end
  end

  def destroy
    Person.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
