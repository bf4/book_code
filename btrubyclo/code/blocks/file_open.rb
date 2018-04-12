#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
class File
  def self.open(name, mode)
    file = new(name, mode)
    return file unless block_given?
    yield(file)
  ensure
    file.close
  end
end
