#!/usr/bin/env ruby
#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
require 'rubygems'
require "daemons"
require 'yaml'
require 'erb'
require 'active_support'

options = YAML.load(
  ERB.new(
  IO.read(
  File.dirname(__FILE__) + "/../../config/daemons.yml"
  )).result).with_indifferent_access
options[:dir_mode] = options[:dir_mode].to_sym

Daemons.run File.dirname(__FILE__) + '/twitter_stream_daemon.rb', options