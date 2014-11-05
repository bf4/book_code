#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rack
  module Adapter
    class Camping
      def initialize(app)
        @app = app
      end

      def call(env)
        env["PATH_INFO"] ||= ""
        env["SCRIPT_NAME"] ||= ""
        controller = @app.run(env['rack.input'], env)
        h = controller.headers
        h.each_pair do |k,v|
          if v.kind_of? URI
            h[k] = v.to_s
          end
        end
        [controller.status, controller.headers, [controller.body.to_s]]
      end
    end
  end
end
