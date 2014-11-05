#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'rtf'

class RtfFormatter

  def initialize(step_mother, io, options)
    @io  = io

    font = RTF::Font.new(RTF::Font::SWISS, 'Verdana')
    @rtf = RTF::Document.new font 
  end

  def after_step_result(keyword, match, multiline, status,
                        exception, indent, background,
                        file_colon_line)
    @rtf.paragraph do |para|
      para << (status.to_s + ': ' + keyword + match.format_args)
    end
  end

  def after_features(features)
    @io.puts @rtf.to_rtf
  end

end

class RtfFormatter
  Styles = {}
  Styles.default = RTF::CharacterStyle.new

  Styles[:passed] = RTF::CharacterStyle.new
  Styles[:passed].foreground = RTF::Colour.new 0, 127, 0 # green

  Styles[:failed] = RTF::CharacterStyle.new
  Styles[:failed].foreground = RTF::Colour.new 127, 0, 0 # red
  Styles[:failed].bold = true

  def after_step_result(keyword, match, multiline, status,
                        exception, indent, background,
                        file_colon_line)
    @rtf.paragraph do |para|
      para.apply(Styles[status]) do |text|
        text << (status.to_s + ': ' + keyword + match.format_args)
      end
    end
  end
end
