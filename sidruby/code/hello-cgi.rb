#!/usr/local/bin/ruby
#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'cgi'
require 'erb'
require 'drb/drb'
$KCODE='euc'

cgi = CGI.new('html3')

cgi.out({"charset"=>"euc-jp"}) {
  cgi.html {
    cgi.head { 
      cgi.title { 'Hello, CGI.' }
    } + cgi.body { "<p>こんにちは、世界。<p>" }
  }
}