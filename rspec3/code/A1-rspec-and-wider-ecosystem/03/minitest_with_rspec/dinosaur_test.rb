#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class Dinosaur
  def fly(rocket)
    rocket.launch!
    @excited = true
  end

  def excited?
    @excited
  end
end

class Rocket
  def launch!
  end
end

require 'minitest/autorun'

require 'rspec/mocks/minitest_integration'
require 'rspec/expectations/minitest_integration'

class DinosaurTest < Minitest::Test
  def test_dinosaurs_fly_rockets
    dinosaur = Dinosaur.new
    rocket = instance_double(Rocket)
    expect(rocket).to receive(:launch!)
    dinosaur.fly(rocket)
    expect(dinosaur).to be_excited
  end
end
