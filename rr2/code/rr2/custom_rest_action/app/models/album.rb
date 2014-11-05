#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Album < ActiveRecord::Base
  def copy
    self.class.new.tap do |new_album|
      attributes.each do |key, value|
        new_album.send("#{key}=", value) unless key == "id"
      end
      new_album.save
    end
  end
end
