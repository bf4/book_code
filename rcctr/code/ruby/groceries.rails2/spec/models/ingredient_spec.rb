#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require 'spec_helper'

describe Ingredient do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :amount => 1,
      :recipe_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Ingredient.create!(@valid_attributes)
  end
end
