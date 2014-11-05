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
    module Range #:nodoc:
      # Return an array when step is called without a block.
      module BlocklessStep
        def self.included(base) #:nodoc:
          base.alias_method_chain :step, :blockless
        end

        if RUBY_VERSION < '1.9'
          def step_with_blockless(value = 1, &block)
            if block_given?
              step_without_blockless(value, &block)
            else
              returning [] do |array|
                step_without_blockless(value) { |step| array << step }
              end
            end
          end
        else
          def step_with_blockless(value = 1, &block)
            if block_given?
              step_without_blockless(value, &block)
            else
              step_without_blockless(value).to_a
            end
          end
        end
      end
    end
  end
end
