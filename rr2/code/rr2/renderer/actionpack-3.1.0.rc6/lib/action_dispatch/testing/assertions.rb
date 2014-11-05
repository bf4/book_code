#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionDispatch
  module Assertions
    autoload :DomAssertions, 'action_dispatch/testing/assertions/dom'
    autoload :ResponseAssertions, 'action_dispatch/testing/assertions/response'
    autoload :RoutingAssertions, 'action_dispatch/testing/assertions/routing'
    autoload :SelectorAssertions, 'action_dispatch/testing/assertions/selector'
    autoload :TagAssertions, 'action_dispatch/testing/assertions/tag'

    extend ActiveSupport::Concern

    include DomAssertions
    include ResponseAssertions
    include RoutingAssertions
    include SelectorAssertions
    include TagAssertions
  end
end

