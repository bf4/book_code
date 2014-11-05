#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView #:nodoc:
  class InlineTemplate #:nodoc:
    include Renderable

    attr_reader :source, :extension, :method_segment

    def initialize(source, type = nil)
      @source = source
      @extension = type
      @method_segment = "inline_#{@source.hash.abs}"
    end

    private
      # Always recompile inline templates
      def recompile?
        true
      end
  end
end
