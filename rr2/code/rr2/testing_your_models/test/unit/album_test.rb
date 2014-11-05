#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test "should be able to report duration based \
        on the combined duration of its songs" do
    album = Album.create
    3.times do 
      album.songs.create(:duration_in_seconds => 5)
    end
    assert_equal 15, album.duration
  end
end
