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
  # This is a thread locals registry for Active Record. For example:
  #
  #   ActiveRecord::RuntimeRegistry.connection_handler
  #
  # returns the connection handler local to the current thread.
  #
  # See the documentation of <tt>ActiveSupport::PerThreadRegistry</tt>
  # for further details.
  class RuntimeRegistry # :nodoc:
    extend ActiveSupport::PerThreadRegistry

    attr_accessor :connection_handler, :sql_runtime, :connection_id

    [:connection_handler, :sql_runtime, :connection_id].each do |val|
      class_eval %{ def self.#{val}; instance.#{val}; end }, __FILE__, __LINE__
      class_eval %{ def self.#{val}=(x); instance.#{val}=x; end }, __FILE__, __LINE__
    end
  end
end
