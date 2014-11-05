#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Require the eval_debugger to get an insight into the methods that aggregations and associations macross are adding.
# All the additions are reported to $stderr just by requiring this file.
class Module
	alias :old_module_eval :module_eval
	def module_eval(*args, &block)
		puts("in #{self.name}, #{if args[1] then "file #{args[1]}" end} #{if args[2] then "on line #{args[2]}" end}:\n#{args[0]}") if args[0]
		old_module_eval(*args, &block)
	end
end
