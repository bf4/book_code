#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  module RbxPath
    module_function
    def is_core_path?(path)
      path.start_with?("kernel") || path.start_with?("lib")
    end

    def convert_path_to_full(path)
      if path.start_with?("kernel")
        File.join File.dirname(Rubinius::KERNEL_PATH), path
      elsif path.start_with?("lib")
        File.join File.dirname(Rubinius::LIB_PATH), path
      else
        path
      end
    end

    def rvm_ruby?(path)
      !!(path =~ /\.rvm/)
    end
  end
end
