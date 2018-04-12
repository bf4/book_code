#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me

Toaster = Struct.new(:serial) do
  def self.find_by_serial(serial)
    new(serial)
  end
end

def current_toaster
  @current_toaster ||= Toaster.find_by_serial('HHGG42')
end

current_toaster # to ensure it does not raise errors

@current_toaster = nil || Toaster.find_by_serial('HHGG42')
