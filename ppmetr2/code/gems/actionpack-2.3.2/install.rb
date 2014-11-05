#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rbconfig'
require 'find'
require 'ftools'

include Config

# this was adapted from rdoc's install.rb by way of Log4r

$sitedir = CONFIG["sitelibdir"]
unless $sitedir
  version = CONFIG["MAJOR"] + "." + CONFIG["MINOR"]
  $libdir = File.join(CONFIG["libdir"], "ruby", version)
  $sitedir = $:.find {|x| x =~ /site_ruby/ }
  if !$sitedir
    $sitedir = File.join($libdir, "site_ruby")
  elsif $sitedir !~ Regexp.quote(version)
    $sitedir = File.join($sitedir, version)
  end
end

# the actual gruntwork
Dir.chdir("lib")

Find.find("action_controller", "action_controller.rb", "action_view", "action_view.rb") { |f|
  if f[-3..-1] == ".rb"
    File::install(f, File.join($sitedir, *f.split(/\//)), 0644, true)
  else
    File::makedirs(File.join($sitedir, *f.split(/\//)))
  end
}