#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveSupport
  class OptionMerger #:nodoc:
    instance_methods.each do |method| 
      undef_method(method) if method !~ /^(__|instance_eval)/
    end
    
    def initialize(context, options)
      @context, @options = context, options
    end
    
    private
      def method_missing(method, *arguments, &block)
        merge_argument_options! arguments
        @context.send(method, *arguments, &block)
      end
      
      def merge_argument_options!(arguments)
        arguments << if arguments.last.respond_to? :merge!
          arguments.pop.dup.merge!(@options)
        else
          @options.dup
        end  
      end
  end
end
