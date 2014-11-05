#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
######################################################################
# Core extension library
#
class Module
  # Check for an existing method in the current class before extending.  IF
  # the method already exists, then a warning is printed and the extension is
  # not added.  Otherwise the block is yielded and any definitions in the
  # block will take effect.
  #
  # Usage:
  #
  #   class String
  #     rake_extension("xyz") do
  #       def xyz
  #         ...
  #       end
  #     end
  #   end
  #
  def rake_extension(method)
    if method_defined?(method)
      $stderr.puts "WARNING: Possible conflict with Rake extension: #{self}##{method} already exists"
    else
      yield
    end
  end
end
