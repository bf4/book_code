#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'faraday'
require 'faraday_middleware'
require 'multi_json'

class Ghee
  class Connection < Faraday::Connection
    attr_reader :hash

    # Instantiates connection, accepts an options hash
    # for authenticated access
    #
    # OAuth2 expects
    #   :access_token => "OAuth Token" 
    #
    # Basic auth expects
    #   :basic_auth => {:user_name => "octocat", :password => "secret"}
    def initialize(hash={})
      @hash = hash
      access_token = hash[:access_token] if hash.has_key?:access_token
      basic_auth = hash[:basic_auth] if hash.has_key?:basic_auth

      super(hash[:api_url] || 'https://api.github.com') do |builder|
        yield builder if block_given?
        builder.use     FaradayMiddleware::EncodeJson
        builder.use     FaradayMiddleware::Mashify
        builder.use     FaradayMiddleware::ParseJson
      #  builder.use     Ghee::Middleware::UriEscape
        builder.adapter Faraday.default_adapter


      end

      self.headers["Authorization"] = "token #{access_token}" if access_token
      self.basic_auth(basic_auth[:user_name], basic_auth[:password]) if basic_auth
      self.headers["Accept"] = 'application/json'

    end
  end
end
