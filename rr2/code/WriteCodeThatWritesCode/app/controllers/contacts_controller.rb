#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ContactsController < ApplicationController
  def current_user
    Struct.new(:account_id, :username).new(1, "Matz")
  end
  def search
    Contact.with_scope(:find => {
            :conditions => ['account_id = ?', current_user.account_id]}) do
      @title = "Your Contacts"
      @results = Contact.find(:all,
                              :conditions => ['name like ?', "%#{params[:term]}%"])
      @display_as = :name
      @display_action = "view"
      render :template => 'shared/search_results'
    end
  end
  search_action_for :contacts
end
