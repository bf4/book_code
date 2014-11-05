#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionController
  class Middleware < Metal
    class ActionMiddleware
      def initialize(controller, app)
        @controller, @app = controller, app
      end

      def call(env)
        request = ActionDispatch::Request.new(env)
        @controller.build(@app).dispatch(:index, request)
      end
    end

    class << self
      alias build new

      def new(app)
        ActionMiddleware.new(self, app)
      end
    end

    attr_internal :app

    def process(action)
      response = super
      self.status, self.headers, self.response_body = response if response.is_a?(Array)
      response
    end

    def initialize(app)
      super()
      @_app = app
    end

    def index
      call(env)
    end
  end
end