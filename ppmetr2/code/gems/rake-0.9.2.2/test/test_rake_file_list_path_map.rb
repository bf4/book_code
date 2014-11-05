#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakeFileListPathMap < Rake::TestCase
  def test_file_list_supports_pathmap
    assert_equal ['a', 'b'], FileList['dir/a.rb', 'dir/b.rb'].pathmap("%n")
  end
end

