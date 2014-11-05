#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ContactsController < ApplicationController
  def list
    @contacts = Contact.find(:all)
  end
  def list
    @contacts = if tag_name = params[:id]
      Tag.find_by_name(tag_name).tagged
    else
      Contact.find(:all)
    end
  end
  def tag
    contact = Contact.find(params[:id])
    contact.tag_with(params[:tag_list])
    contact.save
    render :partial => "content", 
           :locals => {:contact => contact, :form_id => params[:form_id]}
  end
end
