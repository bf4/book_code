#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
After('@javascript') do |scenario|
  if(scenario.failed?)
    page.driver.browser.save_screenshot("html-report/#{scenario.__id__}.png")
    embed("#{scenario.__id__}.png", "image/png", "SCREENSHOT")
  end
end