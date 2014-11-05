#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
# A standard 1.9 feature that's not in MacRuby yet
#
def require_relative(path)
  require File.join(File.dirname(caller[0]), path.to_str)
end
# Spinach uses Ruby's standard StringIO class but doesn't load it
#
require 'stringio'
# Spinach's error reporting asks for the file and line number;
# MacRuby doesn't provide this
class Method
  def source_location
    ['', '']
  end
end
