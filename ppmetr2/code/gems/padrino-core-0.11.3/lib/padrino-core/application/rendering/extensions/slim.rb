#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
begin
  require 'slim'

  if defined? Padrino::Rendering
    Padrino::Rendering.engine_configurations[:slim] =
      {:generator => Temple::Generators::RailsOutputBuffer,
      :buffer => "@_out_buf", :use_html_safe => true}

    class Slim::Template
      include Padrino::Rendering::SafeTemplate
    end
  end
rescue LoadError
end
