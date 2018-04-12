#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
module EasyScreenshots
  # Take a screenshot
  #
  # filename:: if present, this is the filename used for the file, saved within RSpec.configuration.screenshots_dir
  # selector:: if present, this is the selector of the area of the screen to screenshot.  Othorwise, the entire screen is shown.
  def screenshot!(filename: :auto_generate, selector: :none)
    if filename == :auto_generate
      filename = "#{SecureRandom.uuid}.png" 
    else
      filename = "named/#{filename}"
    end

    options = if selector == :none 
                { full: true }
              else
                { selector: selector }
              end

    screenshot_filename = "#{RSpec.configuration.screenshots_dir}/#{filename}"
    FileUtils.rm(screenshot_filename) if File.exists?(screenshot_filename)
    save_screenshot(screenshot_filename, options)
  end

  # Like within, but takes a screenshot after the innards are executred.  Only works with
  # the single-argument version of within.
  def within_with_screenshot(*args)
    if args.length == 1
      within(*args) do
        yield
        screenshot!(selector: args.first)
      end
    else
      puts "WARN: within_with_screenshot doesn't support anything other than a single selector.  You used #{args.inspect}"
      within(*args) do
        yield
      end
    end
  end

end
