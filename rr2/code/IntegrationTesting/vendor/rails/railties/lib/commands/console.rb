#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
irb = RUBY_PLATFORM =~ /mswin32/ ? 'irb.bat' : 'irb'

require 'optparse'
options = { :sandbox => false, :irb => irb }
OptionParser.new do |opt|
  opt.banner = "Usage: console [environment] [options]"
  opt.on('-s', '--sandbox', 'Rollback database modifications on exit.') { |options[:sandbox]| }
  opt.on("--irb=[#{irb}]", 'Invoke a different irb.') { |options[:irb]| }
  opt.parse!(ARGV)
end

libs =  " -r irb/completion"
libs << " -r #{RAILS_ROOT}/config/environment"
libs << " -r console_app"
libs << " -r console_sandbox" if options[:sandbox]
libs << " -r console_with_helpers"

ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
if options[:sandbox]
  puts "Loading #{ENV['RAILS_ENV']} environment in sandbox."
  puts "Any modifications you make will be rolled back on exit."
else
  puts "Loading #{ENV['RAILS_ENV']} environment."
end
exec "#{options[:irb]} #{libs} --simple-prompt"
