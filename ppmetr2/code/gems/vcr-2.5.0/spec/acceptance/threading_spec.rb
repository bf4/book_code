#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe VCR do
  context 'when used in a multithreaded environment', :with_monkey_patches => :excon do
    def recorded_content_for(name)
      VCR.cassette_persisters[:file_system]["#{name}.yml"].to_s
    end

    it 'can use a cassette in an #around_http_request hook', :if => (RUBY_VERSION.to_f > 1.8) do
      VCR.configure do |vcr|
        vcr.around_http_request do |req|
          VCR.use_cassette(req.parsed_uri.path, &req)
        end
      end

      thread = Thread.start do
        Excon.get "http://localhost:#{VCR::SinatraApp.port}/search?q=thread"
      end

      Excon.get "http://localhost:#{VCR::SinatraApp.port}/foo",
        :response_block => Proc.new { thread.join }

      expect(recorded_content_for("search") +
             recorded_content_for("foo")).to include("query: thread", "FOO!")
    end
  end
end

