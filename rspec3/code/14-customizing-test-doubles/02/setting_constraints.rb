#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me
require 'rspec/expectations'
include RSpec::Matchers
require 'rspec/mocks/standalone'

RSpec::Mocks.configuration.color = false

movie = double('Jaws')

expect(movie).to receive(:record_review).with('Great movie!')
expect(movie).to receive(:record_review).with(/Great/)
expect(movie).to receive(:record_review).with('Great movie!', 5)

cart = double

expect(cart).to receive(:add_product).with('Hoodie', anything, anything)

cart = double

expect(cart).to receive(:add_product).with('Hoodie', any_args)

# rubocop:disable Style/NumericLiterals
cart.add_product('Hoodie')
cart.add_product('Hoodie', 27182818)
cart.add_product('Hoodie', 27182818, 'HOODIE-SERIAL-123')
# rubocop:enable Style/NumericLiterals

database = double

expect(database).to receive(:delete_all_the_things).with(no_args)

class BoxOffice
  def find_showtime(options)
    # ...
  end
end


# rubocop:disable Style/NumericLiterals
# rubocop:disable Style/IndentationConsistency
# rubocop:disable Style/CommentIndentation
def use_box_office(box_office)
  expect(box_office).to receive(:find_showtime)
    .with(hash_including(movie: 'Jaws'))

box_office.find_showtime(movie: 'Jaws')
box_office.find_showtime(movie: 'Jaws', zip_code: 97204)
box_office.find_showtime(movie: 'Jaws', city: 'Portland', state: 'OR')
end
# rubocop:enable Style/CommentIndentation
# rubocop:enable Style/IndentationConsistency
# rubocop:enable Style/NumericLiterals

use_box_office(instance_double(BoxOffice))
Object.send(:remove_const, :BoxOffice)

class BoxOffice
  def find_showtime(movie:, zip_code: nil, city: nil, state: nil)
    # ...
  end
end

use_box_office(instance_double(BoxOffice))

RSpec::Matchers.define :a_city_in_oregon do
  match { |options| options[:state] == 'OR' && options[:city] }
end

box_office = instance_double(BoxOffice)

expect(box_office).to receive(:find_showtime).with(a_city_in_oregon)

box_office.find_showtime(movie: 'Jaws', city: 'Portland', state: 'OR')

expect {
  box_office.find_showtime(movie: 'Jaws', city: 'Portland', state: 'ME')
}.to raise_error(a_string_matching 'expected: (a city in oregon)')

greeter = double

expect(greeter).to receive(:hello)
expect(greeter).to receive(:goodbye)

# The following will pass:
greeter.goodbye
greeter.hello

greeter = double

expect {
  expect(greeter).to receive(:hello).ordered
  expect(greeter).to receive(:goodbye).ordered

  # The following will fail:
  greeter.goodbye
  greeter.hello
}.to raise_error(a_string_matching('out of order'))
