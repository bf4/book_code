#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionDispatch
  class Rescue
    def initialize(app, rescuers = {}, &block)
      @app, @rescuers = app, {}
      rescuers.each { |exception, rescuer| rescue_from(exception, rescuer) }
      instance_eval(&block) if block_given?
    end

    def call(env)
      @app.call(env)
    rescue Exception => exception
      if rescuer = @rescuers[exception.class.name]
        env['action_dispatch.rescue.exception'] = exception
        rescuer.call(env)
      else
        raise exception
      end
    end

    protected
      def rescue_from(exception, rescuer)
        exception = exception.class.name if exception.is_a?(Exception)
        @rescuers[exception.to_s] = rescuer
      end
  end
end
