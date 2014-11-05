#!/usr/bin/ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
# Server: ruby p2p.rb password server public-uri private-uri merge-servers
# Sample: ruby p2p.rb foobar server druby://123.123.123.123:1337
#         druby://:1337 druby://foo.bar:1337
# Client: ruby p2p.rb password client server-uri download-pattern [list-only]
# Sample: ruby p2p.rb foobar client druby://localhost:1337 *.rb
##################################################################
# You are not allowed to use this application for anything illegal
# unless you live in a sane place. Insane places currently include
# California (see link) and might soon include the complete
# USA. People using this software are responsible for themselves. I
# can't prevent them from doing illegal stuff for obvious reasons. So
# have fun and do whatever you can get away with for now.
# 
# http://info.sen.ca.gov/pub/bill/sen/sb_0051-0100/
#      sb_96_bill_20050114_introduced.html
##################################################################
require'drb';F=File;def c(u)DRbObject.new((),u)end;def x(u)[P,u].hash;end;def s(
p)F.basename p[/[^|]+/]end;P,M,U,V,*O=$*;M["s"]?(DRb.start_service V,Class.new{
def p(z=O)O.push(*z).uniq;end;new.methods.map{|m|m[/_[_t]/]||private(m)};def y;(
p(U)+p).map{|u|u!=U&&c(u).f(x(u),p(U))};self;end;def f(c,a=O,t=2)x(U)==c&&t<1?
Dir[s(a)]:t<2?[*open(s(a),"rb")]:p(a)end}.new.y;sleep):c(U).f(x(U)).map{|n|c(n).
f(x(n),V,0).map{|f|s f}.map{|f|O[0]?p(f):open(f,"wb")<<c(n).f(x(n),f,1)}}
