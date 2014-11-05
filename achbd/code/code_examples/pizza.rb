#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Pizza
  def initialize(options)
  end
  
  def has_a_really_great_sauce?
    true
  end
  
  def has_a_ton_of_cheese?
    true
  end
  
  def tastes_really_good?
    true
  end
  
  def available_by_the_slice?
    true
  end
end

RSpec::Matchers.define :taste_really_good do
  match do |actual|
    actual.tastes_really_good?
  end
end

shared_examples_for "any pizza" do
  it "tastes really good" do
    @pizza.should taste_really_good
  end
  it "is available by the slice" do
    @pizza.should be_available_by_the_slice
  end
end

describe "New York style thin crust pizza" do
  before(:each) do
    @pizza = Pizza.new(:region => 'New York', :style => 'thin crust')
  end

  it_behaves_like "any pizza"

  it "has a really great sauce" do
    @pizza.should have_a_really_great_sauce
  end
end

describe "Chicago style stuffed pizza" do
  before(:each) do
    @pizza = Pizza.new(:region => 'Chicago', :style => 'stuffed')
  end

  it_behaves_like "any pizza"

  it "has a ton of cheese" do
    @pizza.should have_a_ton_of_cheese
  end
end
