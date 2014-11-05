#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module VCR
  # @private
  module Logger
    def log(message, indentation_level = 0)
      indentation = '  ' * indentation_level
      log_message = indentation + log_prefix + message
      VCR.configuration.debug_logger.puts log_message
    end

    def log_prefix
      ''
    end

    def request_summary(request, request_matchers)
      attributes = [request.method, request.uri]
      attributes << request.body.to_s[0, 80].inspect if request_matchers.include?(:body)
      attributes << request.headers.inspect          if request_matchers.include?(:headers)
      "[#{attributes.join(" ")}]"
    end

    def response_summary(response)
      "[#{response.status.code} #{response.body[0, 80].inspect}]"
    end
  end
end
