#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'cgi'
require 'cgi/session'
require 'drb'
 
class CGI #:nodoc:all
  class Session
    class DRbStore
      @@session_data = DRbObject.new(nil, 'druby://localhost:9192')
 
      def initialize(session, option=nil)
        @session_id = session.session_id
      end
 
      def restore
        @h = @@session_data[@session_id] || {}
      end
 
      def update
        @@session_data[@session_id] = @h
      end
 
      def close
        update
      end
 
      def delete
        @@session_data.delete(@session_id)
      end
    end
  end
end
