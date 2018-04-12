#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec.configure do |config|
  config.around(:example) do |ex|
    original_env = ENV.to_hash
    ex.run
    ENV.replace(original_env)
  end
end

require 'fileutils'

RSpec.configure do |config|
  config.before(:suite) do
    # Remove leftover temporary files
    FileUtils.rm_rf('tmp')
  end
end

RSpec.configure do |config|
  config.before(:all) do
    # ...
  end
end
