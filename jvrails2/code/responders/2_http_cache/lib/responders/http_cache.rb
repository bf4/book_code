#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module Responders
  module HttpCache
    delegate :response, to: :controller
    def to_format
      return if do_http_cache? && do_http_cache!
      super
    end

    private

    def do_http_cache!
      response.last_modified ||= max_timestamp if max_timestamp
      head :not_modified if fresh = request.fresh?(response)
      fresh
    end

    # Iterate through all resources and find the last updated.
    def max_timestamp
      @max_timestamp ||= resources.flatten.map do |resource|
        resource.updated_at.try(:utc) if resource.respond_to?(:updated_at)
      end.compact.max
    end
    # Just trigger the cache if it's a GET request and
    # perform caching is enabled.
    def do_http_cache?
      get? && ActionController::Base.perform_caching
    end
  end
end