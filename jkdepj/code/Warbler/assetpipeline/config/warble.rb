#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
Warbler::Config.new do |config|
  config.jar_name = "twitalytics"
  config.dirs << "db"
  config.excludes = FileList["**/*/*.box"]
  config.bundle_without = []
  config.dirs << "bin"
  config.includes = FileList["Rakefile"]
  config.webxml.jruby.max.runtimes = 1
end
