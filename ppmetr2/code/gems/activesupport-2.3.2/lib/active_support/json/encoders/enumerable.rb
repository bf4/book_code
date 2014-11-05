#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Enumerable
  # Returns a JSON string representing the enumerable. Any +options+
  # given will be passed on to its elements. For example:
  #
  #   users = User.find(:all)
  #   # => users.to_json(:only => :name)
  #
  # will pass the <tt>:only => :name</tt> option to each user.
  def to_json(options = {}) #:nodoc:
    "[#{map { |value| ActiveSupport::JSON.encode(value, options) } * ', '}]"
  end
end
