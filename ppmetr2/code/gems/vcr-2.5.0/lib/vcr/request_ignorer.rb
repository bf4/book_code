#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'set'
require 'vcr/util/hooks'

module VCR
  # @private
  class RequestIgnorer
    include VCR::Hooks

    define_hook :ignore_request

    LOCALHOST_ALIASES = %w( localhost 127.0.0.1 0.0.0.0 )

    def initialize
      ignore_request do |request|
        host = request.parsed_uri.host
        ignored_hosts.include?(host)
      end
    end

    def ignore_localhost=(value)
      if value
        ignore_hosts(*LOCALHOST_ALIASES)
      else
        ignored_hosts.reject! { |h| LOCALHOST_ALIASES.include?(h) }
      end
    end

    def ignore_hosts(*hosts)
      ignored_hosts.merge(hosts)
    end

    def ignore?(request)
      invoke_hook(:ignore_request, request).any?
    end

  private

    def ignored_hosts
      @ignored_hosts ||= Set.new
    end
  end
end

