#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Extends the module object with module and instance accessors for class attributes, 
# just like the native attr* accessors for instance attributes.
#
#  module AppConfiguration
#    mattr_accessor :google_api_key
#    self.google_api_key = "123456789"
#
#    mattr_accessor :paypal_url
#    self.paypal_url = "www.sandbox.paypal.com"
#  end
#
#  AppConfiguration.google_api_key = "overriding the api key!"
class Module
  def mattr_reader(*syms)
    syms.each do |sym|
      next if sym.is_a?(Hash)
      class_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}  # unless defined? @@pagination_options
          @@#{sym} = nil          #   @@pagination_options = nil
        end                       # end
                                  #
        def self.#{sym}           # def self.pagination_options
          @@#{sym}                #   @@pagination_options
        end                       # end
                                  #
        def #{sym}                # def pagination_options
          @@#{sym}                #   @@pagination_options
        end                       # end
      EOS
    end
  end
  
  def mattr_writer(*syms)
    options = syms.extract_options!
    syms.each do |sym|
      class_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}                       # unless defined? @@pagination_options
          @@#{sym} = nil                               #   @@pagination_options = nil
        end                                            # end
                                                       #
        def self.#{sym}=(obj)                          # def self.pagination_options=(obj)
          @@#{sym} = obj                               #   @@pagination_options = obj
        end                                            # end
                                                       #
        #{"                                            #
        def #{sym}=(obj)                               # def pagination_options=(obj)
          @@#{sym} = obj                               #   @@pagination_options = obj
        end                                            # end
        " unless options[:instance_writer] == false }  # # instance writer above is generated unless options[:instance_writer] == false
      EOS
    end
  end
  
  def mattr_accessor(*syms)
    mattr_reader(*syms)
    mattr_writer(*syms)
  end
end
