#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'erb'

class ERB
  class ERBString < String 
    def to_s; self; end

    def erb_concat(s)
      if self.class === s
        concat(s)
      else
        concat(erb_quote(s))
      end
    end

    def erb_quote(s); s; end
  end
end

class ERB4Html < ERB 
  def self.quoted(s)
    HtmlString.new(s)
  end

  class HtmlString < ERB::ERBString 
    def erb_quote(s)
      ERB::Util::html_escape(s)
    end
  end

  def set_eoutvar(compiler, eoutvar = '_erbout') 
    compiler.put_cmd = "#{eoutvar}.concat"
    compiler.insert_cmd = "#{eoutvar}.erb_concat"
    compiler.pre_cmd = ["#{eoutvar} = ERB4Html.quoted('')"]
    compiler.post_cmd = [eoutvar]
  end
  
  module Util
    def h(s)
      q(ERB::Util.h(s))
    end
    def u(s)
      q(ERB::Util.u(s))
    end
    
    def q(s)
      HtmlString.new(s)
    end
  end
end

