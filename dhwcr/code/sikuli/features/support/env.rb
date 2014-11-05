#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'java'
require 'sikuli'
class BrowserWorld
  # API methods go here...

  def initialize
    @screen = Sikuli::Screen.new                  # from the sikuli gem
    @script = org.sikuli.script.SikuliScript.new  # from the original Java lib
    @script.open_app '/Applications/Google Chrome.app'
    sleep 2
  end
  def close
    @screen.type 'W', KeyModifier::CMD
    @script.close_app '/Applications/Google Chrome.app'
  end

  def visit(url)
    @screen.click "location-bar.png"
    @screen.type "#{url}\n"
  end

  def follow_link_to(name)
    @screen.click "#{name}.png"
  end
  
  def verify_underlined_link_to(name)
    @screen.find "#{name.downcase}-underlined.png"
  end
end
World { BrowserWorld.new }
After { close }
