#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  # = Active Record No Touching
  module NoTouching
    extend ActiveSupport::Concern

    module ClassMethods
      # Lets you selectively disable calls to `touch` for the
      # duration of a block.
      #
      # ==== Examples
      #   ActiveRecord::Base.no_touching do
      #     Project.first.touch  # does nothing
      #     Message.first.touch  # does nothing
      #   end
      #
      #   Project.no_touching do
      #     Project.first.touch  # does nothing
      #     Message.first.touch  # works, but does not touch the associated project
      #   end
      #
      def no_touching(&block)
        NoTouching.apply_to(self, &block)
      end
    end

    class << self
      def apply_to(klass) #:nodoc:
        klasses.push(klass)
        yield
      ensure
        klasses.pop
      end

      def applied_to?(klass) #:nodoc:
        klasses.any? { |k| k >= klass }
      end

      private
        def klasses
          Thread.current[:no_touching_classes] ||= []
        end
    end

    def no_touching?
      NoTouching.applied_to?(self.class)
    end

    def touch(*)
      super unless no_touching?
    end
  end
end
