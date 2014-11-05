#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "highline"
require "forwardable"

$terminal = HighLine.new

module Kernel
  extend Forwardable
  def_delegators :$terminal, :agree, :ask, :say
end
