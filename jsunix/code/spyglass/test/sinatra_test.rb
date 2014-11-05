#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
require 'helper'
require 'excon'

class SinatraTest < MiniTest::Unit::TestCase
  def setup
    config_ru <<-RU
      require 'sinatra'

      get '/zing' do
        redirect 'http://example.com'
      end

      run Sinatra::Application
    RU
    
    spyglass
  end

  def test_it_responds
    response = Excon.get("http://0.0.0.0:#{PORT}/zing")

    assert_equal 302, response.status, "Didn't get the right response code"
    assert_match /example/, response.headers['Location'], "Didn't get the right location header"
  end
end
