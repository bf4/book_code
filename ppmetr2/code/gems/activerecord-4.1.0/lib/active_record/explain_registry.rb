#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/per_thread_registry'

module ActiveRecord
  # This is a thread locals registry for EXPLAIN. For example
  #
  #   ActiveRecord::ExplainRegistry.queries
  #
  # returns the collected queries local to the current thread.
  #
  # See the documentation of <tt>ActiveSupport::PerThreadRegistry</tt>
  # for further details.
  class ExplainRegistry # :nodoc:
    extend ActiveSupport::PerThreadRegistry

    attr_accessor :queries, :collect

    def initialize
      reset
    end

    def collect?
      @collect
    end

    def reset
      @collect = false
      @queries = []
    end
  end
end
