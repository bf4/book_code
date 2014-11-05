#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class LoginController < ApplicationController
  def index 
    if request.post?
      redirect_to :controller => 'ledger', :action => 'list'
    end 
  end
  def direct_to_register     
    redirect_to :controller => 'register'
  end
end
