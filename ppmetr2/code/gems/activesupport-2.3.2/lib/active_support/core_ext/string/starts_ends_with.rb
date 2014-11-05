#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module String #:nodoc:
      # Additional string tests.
      module StartsEndsWith
        def self.append_features(base)
          if '1.8.7 and up'.respond_to?(:start_with?)
            base.class_eval do
              alias_method :starts_with?, :start_with?
              alias_method :ends_with?, :end_with?
            end
          else
            super
            base.class_eval do
              alias_method :start_with?, :starts_with?
              alias_method :end_with?, :ends_with?
            end
          end
        end

        # Does the string start with the specified +prefix+?
        def starts_with?(prefix)
          prefix = prefix.to_s
          self[0, prefix.length] == prefix
        end

        # Does the string end with the specified +suffix+?
        def ends_with?(suffix)
          suffix = suffix.to_s
          self[-suffix.length, suffix.length] == suffix      
        end
      end
    end
  end
end
