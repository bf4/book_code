#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Padrino
  ##
  # This module extend Sinatra::ShowExceptions adding Padrino as "Framework".
  #
  # @private
  class ShowExceptions < Sinatra::ShowExceptions
    private
      def frame_class(frame)
        if frame.filename =~ /lib\/sinatra.*\.rb|lib\/padrino.*\.rb/
          "framework"
        elsif (defined?(Gem) && frame.filename.include?(Gem.dir)) ||
              frame.filename =~ /\/bin\/(\w+)$/ ||
              frame.filename =~ /Ruby\/Gems/
          "system"
        else
          "app"
        end
      end
  end # ShowExceptions
end # Padrino
