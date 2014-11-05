#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

describe ApplicationHelper do
  describe "#display_for(:role)" do
    context "when the current user has the role" do
      it "displays the content" do
        user = stub('User', :in_role? => true)
        helper.stub(:current_user).and_return(user)
        content = helper.display_for(:existing_role) {"content"}
        content.should == "content"
      end
    end
  end
end
