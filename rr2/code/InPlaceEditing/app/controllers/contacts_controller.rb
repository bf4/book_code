#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ContactsController < ApplicationController
  Contact.content_columns.each do |column|
    in_place_edit_for :contact, column.name
  end
  def index
    list
    render :action => 'list'
  end

  def list
    @contact_pages, @contacts = paginate :contacts, :per_page => 10
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:notice] = 'Contact was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:notice] = 'Contact was successfully updated.'
      redirect_to :action => 'show', :id => @contact
    else
      render :action => 'edit'
    end
  end

  def destroy
    Contact.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
