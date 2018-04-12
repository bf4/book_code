#---
# Excerpted from "Docker for Rails Developers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ridocker for more book information.
#---
class User < ApplicationRecord
  validates_presence_of :first_name, :last_name
end
