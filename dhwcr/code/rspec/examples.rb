#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
RSpec::Matchers.define :please do |people|
  match do |book|
    book.pleases?(people)
  end
end

class SomeObject
  def has_flair?
    true
  end

  def festive?
    true
  end
end

describe 'rspec-expectations' do
  let(:some_object) { SomeObject.new }
  let(:this_book)   { Book.new       }

  it 'allows expectations with #should' do
    (2 + 2).should == 4

    (2 + 2).should != 4
    (2 + 2).should_not == 4

    (2 + 2).should be > 3
    (2 + 2).should be <= 5
    Math.sqrt(2).should be_within(0.001).of(1.414)

    'hello'.should start_with('hel')
    'hello'.should =~ /ell/

    [1, 2, 3].should include(2)
    {:a => 1, :b => 2}.should have_key(:a)

    # assuming some_object supports a has_flair?() method
    some_object.should have_flair

    # assuming some_object supports a festive?() method
    some_object.should be_festive

    lambda {
      SomeNonExistentClass.new
    }.should raise_error(NameError)

    this_book.should please('developers')
  end
end


class Book
  def pleases?(people)
    people == 'developers'
  end
end
