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
require 'tempfile'

class TimeoutTest < MiniTest::Unit::TestCase
  def setup
    @lifeline = Tempfile.open('lifeline')
    @uri = "http://0.0.0.0:#{PORT}/zing"
    
    config_ru <<-RU
      require 'sinatra'

      get '/zing' do
        redirect 'http://example.com'
      end
      
      at_exit { File.unlink('#{@lifeline.path}') rescue nil }

      run Sinatra::Application
    RU
    spyglass :timeout => 3
  end
  
  def test_times_out_after_timeout_has_expired
    Excon.get(@uri)
    sleep 3.5
    
    # When the Master process loads the Sinatra it will set up the at_exit
    # hook defined above. That process should exit after 3 seconds, removing
    # our @lifeline file. If the file still exists at this point then the
    # timeout didn't happen properly.
    refute File.file?(@lifeline.path), "Spyglass didn't time out properly"
  end
  
  def test_doesnt_time_out_if_requests_keep_coming
    Excon.get(@uri)
    sleep 1
    Excon.get(@uri)
    sleep 1
    
    Excon.get(@uri)
    sleep 1.5
    Excon.get(@uri)
    
    # When the Master process loads the Sinatra it will set up the at_exit
    # hook defined above. Since we're keeping the server saturated with
    # requests, definitely not letting it sit idle for 3 seconds, the @lifeline
    # file should still exist when we get here.
    assert File.file?(@lifeline.path), "Spyglass didn't time out properly"
  end
end
