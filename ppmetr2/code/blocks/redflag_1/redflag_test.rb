#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require_relative '../../test/assertions'

# add this folder to the load path
$: << File.expand_path(File.dirname(__FILE__))

# hack Kernel#puts
$PUTS = []
module Kernel
  alias_method :old_puts, :puts
  def puts(s); $PUTS << s; end
end

# setup test
require_relative 'redflag.rb'

# de-hack Kernel#puts
module Kernel
  alias_method :puts, :old_puts
end

# remove this folder from load path
$:.pop

# test!
assert_equals ["ALERT: an event that always happens"], $PUTS
