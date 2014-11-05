#!/usr/local/bin/ruby
#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---

unless ARGV.first == "no_build"
  build_number = build_number = `svn log -q -rhead http://dev.rubyonrails.org/svn/rails`.scan(/r([0-9]*)/).first.first.to_i
end

%w( actionwebservice actionmailer actionpack activerecord railties activesupport ).each do |pkg|
  puts "Pushing: #{pkg} (#{build_number})"
  if build_number
    `cd #{pkg} && rm -rf pkg && PKG_BUILD=#{build_number} rake pgem && cd ..`
  else
    `cd #{pkg} && rm -rf pkg && rake pgem && cd ..`
  end
end
