#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
class Book
  def pleases?(people)
    people == 'developers'
  end
end

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
    expect(2 + 2).to == 4

    expect(2 + 2).not_to == 5
    expect(2 + 2).to be > 3

    expect('hello').to =~ /ell/
    expect(some_object).to be_festive

    expect {
      SomeNonExistentClass.new
    }.to raise_error(NameError)

    expect(this_book).to please('developers')
  end
end
