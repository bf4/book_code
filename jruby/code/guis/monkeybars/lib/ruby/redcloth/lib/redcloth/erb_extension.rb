#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class ERB
  module Util

    #
    # A utility method for transforming Textile in _s_ to HTML.
    # 
    # 	require "erb"
    # 	include ERB::Util
    # 	
    # 	puts textilize("Isn't ERB *great*?")
    # 
    # _Generates_
    # 
    # 	<p>Isn&#8217;t <span class="caps">ERB</span> <strong>great</strong>?</p>
    #
    def textilize( s )
      if s && s.respond_to?(:to_s)
        RedCloth.new( s.to_s ).to_html
      end
    end

    alias t textilize
    module_function :t
    module_function :textilize

  end
end
