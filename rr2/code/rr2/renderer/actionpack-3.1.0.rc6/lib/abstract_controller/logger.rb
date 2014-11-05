#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "active_support/core_ext/logger"
require "active_support/benchmarkable"

module AbstractController
  module Logger
    extend ActiveSupport::Concern

    included do
      config_accessor :logger
      extend ActiveSupport::Benchmarkable
    end
  end
end
