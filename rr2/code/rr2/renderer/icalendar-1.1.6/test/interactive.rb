#!/usr/bin/env ruby
#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---

# NOTE: you must have installed ruby-breakpoint in order to use this script.
# Grab it using gem with "gem install ruby-breakpoint --remote" or download
# from the website (http://ruby-breakpoint.rubyforge.org/) then run setup.rb

$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'breakpoint'

require 'icalendar'

cal = Icalendar::Parser.new(File.new("life.ics")).parse
#cal = Icalendar::Calendar.new

breakpoint
