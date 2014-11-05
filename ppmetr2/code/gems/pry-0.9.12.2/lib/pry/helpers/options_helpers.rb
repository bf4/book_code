#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  module Helpers
    module OptionsHelpers
      module_function

      # Add method options to the Slop instance
      def method_options(opt)
        @method_target = target
        opt.on :M, "instance-methods", "Operate on instance methods."
        opt.on :m, :methods, "Operate on methods."
        opt.on :s, :super, "Select the 'super' method. Can be repeated to traverse the ancestors.", :as => :count
        opt.on :c, :context, "Select object context to run under.", :argument => true do |context|
          @method_target = Pry.binding_for(target.eval(context))
        end
      end

      # Get the method object parsed by the slop instance
      def method_object
        @method_object ||= get_method_or_raise(args.empty? ? nil : args.join(" "), @method_target,
                            :super => opts[:super],
                            :instance => opts.present?(:'instance-methods') && !opts.present?(:'methods'),
                            :methods  => opts.present?(:'methods') && !opts.present?(:'instance-methods')
                           )
      end
    end
  end
end
