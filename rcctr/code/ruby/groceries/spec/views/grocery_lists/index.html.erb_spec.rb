#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require 'spec_helper'

describe "grocery_lists/index.html.erb" do
  before(:each) do
    assign(:grocery_lists, [
      stub_model(GroceryList,
        :name => "Name"
      ),
      stub_model(GroceryList,
        :name => "Name"
      )
    ])
  end

  it "renders a list of grocery_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
