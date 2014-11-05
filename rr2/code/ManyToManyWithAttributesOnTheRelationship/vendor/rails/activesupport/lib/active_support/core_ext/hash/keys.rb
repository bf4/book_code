#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Hash #:nodoc:
      module Keys
        # Return a new hash with all keys converted to strings.
        def stringify_keys
          inject({}) do |options, (key, value)|
            options[key.to_s] = value
            options
          end
        end

        # Destructively convert all keys to strings.
        def stringify_keys!
          keys.each do |key|
            unless key.class.to_s == "String" # weird hack to make the tests run when string_ext_test.rb is also running
              self[key.to_s] = self[key]
              delete(key)
            end
          end
          self
        end

        # Return a new hash with all keys converted to symbols.
        def symbolize_keys
          inject({}) do |options, (key, value)|
            options[key.to_sym] = value
            options
          end
        end

        # Destructively convert all keys to symbols.
        def symbolize_keys!
          keys.each do |key|
            unless key.is_a?(Symbol)
              self[key.to_sym] = self[key]
              delete(key)
            end
          end
          self
        end

        alias_method :to_options,  :symbolize_keys
        alias_method :to_options!, :symbolize_keys!

        def assert_valid_keys(*valid_keys)
          unknown_keys = keys - [valid_keys].flatten
          raise(ArgumentError, "Unknown key(s): #{unknown_keys.join(", ")}") unless unknown_keys.empty?
        end
      end
    end
  end
end
