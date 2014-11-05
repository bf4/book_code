#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      raise AccessDenied
    end
  end

  describe "handling AccessDenied exceptions" do
    it "redirects to the /401.html (access denied) page" do
      get :index
      response.should redirect_to('/401.html')
    end
  end
end
