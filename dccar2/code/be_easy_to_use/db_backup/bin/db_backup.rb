#!/usr/bin/env ruby
#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
#!/usr/bin/env ruby

# Bring OptionParser into the namespace
require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|

  # Create a switch
  opts.on("-i","--iteration") do 
    options[:iteration] = true
  end

  # Create a flag
  opts.on("-u USER") do |user|
    options[:user] = user
  end
  opts.on("-u USER") do |user|
    unless user =~ /^.+\..+$/
      raise ArgumentError,"USER must be in 'first.last' format" 
    end
    options[:user] = user
  end
  opts.on("-u USER",
          /^.+\..+$/) do |user|
    options[:user] = user
  end

  opts.on("-p PASSWORD") do |password|
    options[:password] = password
  end
  
end

begin
option_parser.parse!
puts options.inspect
rescue OptionParser::InvalidArgument => ex
  STDERR.puts ex.message
  STDERR.puts option_parser
end

if ARGV.include? 'DEBUG'
  puts "iteration: #{options[:iteration]}"
  puts "user: #{options[:user]}"
  puts "password: #{options[:password]}"
  ARGV.each do |database|
    puts database unless database == 'DEBUG'
  end
end
