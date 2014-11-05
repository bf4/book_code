#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class JsonParamsParsingTest < ActionController::IntegrationTest
  class TestController < ActionController::Base
    class << self
      attr_accessor :last_request_parameters
    end

    def parse
      self.class.last_request_parameters = request.request_parameters
      head :ok
    end
  end

  def teardown
    TestController.last_request_parameters = nil
  end

  test "parses json params for application json" do
    assert_parses(
      {"person" => {"name" => "David"}},
      "{\"person\": {\"name\": \"David\"}}", { 'CONTENT_TYPE' => 'application/json' }
    )
  end

  test "parses json params for application jsonrequest" do
    assert_parses(
      {"person" => {"name" => "David"}},
      "{\"person\": {\"name\": \"David\"}}", { 'CONTENT_TYPE' => 'application/jsonrequest' }
    )
  end

  private
    def assert_parses(expected, actual, headers = {})
      with_routing do |set|
        set.draw do |map|
          map.connect ':action', :controller => "json_params_parsing_test/test"
        end

        post "/parse", actual, headers
        assert_response :ok
        assert_equal(expected, TestController.last_request_parameters)
      end
    end
end
