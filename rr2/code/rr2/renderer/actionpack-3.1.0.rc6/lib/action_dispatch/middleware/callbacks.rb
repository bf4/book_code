#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'active_support/core_ext/module/delegation'

module ActionDispatch
  # Provide callbacks to be executed before and after the request dispatch.
  class Callbacks
    include ActiveSupport::Callbacks

    define_callbacks :call, :rescuable => true

    class << self
      delegate :to_prepare, :to_cleanup, :to => "ActionDispatch::Reloader"
    end

    def self.before(*args, &block)
      set_callback(:call, :before, *args, &block)
    end

    def self.after(*args, &block)
      set_callback(:call, :after, *args, &block)
    end

    def initialize(app, unused = nil)
      ActiveSupport::Deprecation.warn "Passing a second argument to ActionDispatch::Callbacks.new is deprecated." unless unused.nil?
      @app = app
    end

    def call(env)
      run_callbacks :call do
        @app.call(env)
      end
    end
  end
end
