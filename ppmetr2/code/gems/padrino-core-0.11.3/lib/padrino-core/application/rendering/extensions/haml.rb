#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
begin
  require 'haml'
  require 'haml/helpers/xss_mods'
  require 'haml/helpers/action_view_extensions'

  module Haml
    module Helpers
      include XssMods
      include ActionViewExtensions
    end

    module Util
      def self.rails_xss_safe?
        true
      end
    end
  end

  if defined? Padrino::Rendering
    Padrino::Rendering.engine_configurations[:haml] =
      {:escape_html => true}

    class Tilt::HamlTemplate
      include Padrino::Rendering::SafeTemplate
    end
  end
rescue LoadError
end
