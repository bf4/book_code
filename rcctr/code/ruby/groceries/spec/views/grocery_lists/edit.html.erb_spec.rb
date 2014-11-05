#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require 'spec_helper'

describe "grocery_lists/edit.html.erb" do
  before(:each) do
    @grocery_list = assign(:grocery_list, stub_model(GroceryList,
      :name => "MyString"
    ))
  end

  it "renders the edit grocery_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grocery_lists_path(@grocery_list), :method => "post" do
      assert_select "input#grocery_list_name", :name => "grocery_list[name]"
    end
  end
end
