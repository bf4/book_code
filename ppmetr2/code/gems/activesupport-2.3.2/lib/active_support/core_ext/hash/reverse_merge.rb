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
    module Hash #:nodoc:
      # Allows for reverse merging two hashes where the keys in the calling hash take precedence over those
      # in the <tt>other_hash</tt>. This is particularly useful for initializing an option hash with default values:
      #
      #   def setup(options = {})
      #     options.reverse_merge! :size => 25, :velocity => 10
      #   end
      #
      # Using <tt>merge</tt>, the above example would look as follows:
      #
      #   def setup(options = {})
      #     { :size => 25, :velocity => 10 }.merge(options)
      #   end
      #
      # The default <tt>:size</tt> and <tt>:velocity</tt> are only set if the +options+ hash passed in doesn't already
      # have the respective key.
      module ReverseMerge
        # Performs the opposite of <tt>merge</tt>, with the keys and values from the first hash taking precedence over the second.
        def reverse_merge(other_hash)
          other_hash.merge(self)
        end

        # Performs the opposite of <tt>merge</tt>, with the keys and values from the first hash taking precedence over the second.
        # Modifies the receiver in place.
        def reverse_merge!(other_hash)
          replace(reverse_merge(other_hash))
        end

        alias_method :reverse_update, :reverse_merge!
      end
    end
  end
end
