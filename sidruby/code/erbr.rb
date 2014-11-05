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
class ERBRestrict < ERB
  class RestrictString < ERB::ERBString
    def erb_concat(s)
      raise SecurityError if s.tainted?
      concat(s)
    end
  end
  def set_eoutvar(compiler, eoutvar = '_erbout')
    compiler.put_cmd = "#{eoutvar}.concat"
    compiler.insert_cmd = "#{eoutvar}.erb_concat"
    compiler.pre_cmd = ["#{eoutvar} = ERBRestrict::RestrictString.new('')"]
    compiler.post_cmd = [eoutvar]
  end
end

