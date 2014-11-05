#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
module ActionController
  module Routing #:nodoc:
    class RouteSet #:nodoc:
      alias_method :draw_without_selenium_routes, :draw
      def draw
        draw_without_selenium_routes do |map|
          map.connect 'selenium/setup',
            :controller => 'selenium', :action => 'setup'
          map.connect 'selenium/tests/*testname',
            :controller => 'selenium', :action => 'test_file'
          map.connect 'selenium/postResults',
            :controller => 'selenium', :action => 'record'
          map.connect 'selenium/postResults/:logFile',
            :controller => 'selenium', :action => 'record', :requirements => { :logFile => /.*/ }
          map.connect 'selenium/*filename',
            :controller => 'selenium', :action => 'support_file'
          map.connect 'switch_environment',
            :controller => 'switch_environment', :action => 'index'  
          yield map if block_given?
        end
      end
    end
  end
end
