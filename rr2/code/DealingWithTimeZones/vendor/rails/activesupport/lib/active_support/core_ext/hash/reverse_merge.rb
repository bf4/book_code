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
      # Allows for reverse merging where its the keys in the calling hash that wins over those in the <tt>other_hash</tt>.
      # This is particularly useful for initializing an incoming option hash with default values:
      #
      #   def setup(options = {})
      #     options.reverse_merge! :size => 25, :velocity => 10
      #   end
      #
      # The default :size and :velocity is only set if the +options+ passed in doesn't already have those keys set.
      module ReverseMerge
        def reverse_merge(other_hash)
          other_hash.merge(self)
        end

        def reverse_merge!(other_hash)
          replace(reverse_merge(other_hash))
        end

        alias_method :reverse_update, :reverse_merge
      end
    end
  end
end