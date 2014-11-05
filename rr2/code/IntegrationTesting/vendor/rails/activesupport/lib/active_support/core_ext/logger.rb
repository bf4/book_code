#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# Adds the 'around_level' method to Logger.

class Logger
  def self.define_around_helper(level)
    module_eval <<-end_eval
      def around_#{level}(before_message, after_message, &block)
        self.#{level}(before_message)
        return_value = block.call(self)
        self.#{level}(after_message)
        return return_value
      end
    end_eval
  end
  [:debug, :info, :error, :fatal].each {|level| define_around_helper(level) }

end