#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
# Use Bundler (preferred)
environment = File.expand_path('../../vendor/gems/environment', __FILE__)
if File.exist?("#{environment}.rb")
  require environment

# Use 2.x style vendor/rails and RubyGems
else
  vendor_rails = File.expand_path('../../vendor/rails', __FILE__)
  if File.exist?(vendor_rails)
    Dir["#{vendor_rails}/*/lib"].each { |path| $:.unshift(path) }
  end

  require 'rubygems'
end

require 'rails'
