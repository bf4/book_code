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
  test "can copy an album" do
    original_album = Album.create(:title => "For Those About to Rock", :artist => "AC/DC")
    new_album = original_album.copy
    assert new_album.id != original_album.id, "New album should have its own id"
    new_album.attributes.each do |key, value|
      assert_equal original_album.attributes[key], value unless key == "id"
    end
  end
end
