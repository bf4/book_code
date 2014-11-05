#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
#FIXME Remove if ArJdbcMysql will give.
module ArJdbcMySQL #:nodoc:
  class Error < StandardError #:nodoc:
    attr_accessor :error_number, :sql_state

    def initialize msg
      super
      @error_number = nil
      @sql_state    = nil
    end

    # Mysql gem compatibility
    alias_method :errno, :error_number
    alias_method :error, :message
  end
end
