#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require 'spec_helper'

describe Recipe do

  before(:each) do
    @recipe = Factory.build(:soup)
  end

  before(:each) do
    @recipe = Factory.create(:soup)
  end

  it "provides servings and cook time" do
    @recipe.servings.should == 1
    @recipe.cook_time_minutes.should == 20
  end

  it "can add ingredients" do
    @recipe.add_ingredient(1, "sugar")
  end

  describe "can create a grocery list" do
    it "including all the ingredients" do
      @recipe.add_ingredient(1, "tomato")
      @recipe.add_ingredient(2, "tomato")
      @recipe.add_ingredient(1, "carrot")
      @recipe.grocery_list.should == ['1 carrot', '3 tomato']
    end

    it "when there are no ingredients" do
      @recipe.grocery_list.should == []
    end
  end
end
