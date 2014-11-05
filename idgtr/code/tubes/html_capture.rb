#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'rspec/core/formatters/html_formatter'
RSpec.configure do |config|
  config.before :all do
    $example_num = 1
  end
  config.after do
    `osascript -e 'tell application "Firefox" to activate'`
    `screencapture #{$example_num}.png` #(1)
    $example_num += 1
  end
end


class HtmlCapture < RSpec::Core::Formatters::HtmlFormatter
  def extra_failure_content(failure)
    img = %Q(<img src="#{example_number}.png"
                  alt="" width="25%" height="25%" />)
    super(failure) + img
  end
end
