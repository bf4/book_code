#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class SongTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
class SongTest < ActiveSupport::TestCase
  test "should be findable by title" do
    song = Song.create(:title => "Bat Chain Puller")
    assert_equal song, Song.find_by_title("Bat Chain Puller")
  end
end
