#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Copyright (c) 2010-2012 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
#
# AwesomePrint might be loaded implicitly through ~/.irbrc or ~/.pryrc
# so do nothing for subsequent requires.
#
unless defined?(AwesomePrint::Inspector)
  %w(array string method object class kernel).each do |file|
    require File.dirname(__FILE__) + "/awesome_print/core_ext/#{file}"
  end

  require File.dirname(__FILE__) + "/awesome_print/inspector"
  require File.dirname(__FILE__) + "/awesome_print/formatter"
  require File.dirname(__FILE__) + "/awesome_print/version"
  require File.dirname(__FILE__) + "/awesome_print/core_ext/logger" if defined?(Logger)
  #
  # Load the following under normal circumstances as well as in Rails
  # console when required from ~/.irbrc or ~/.pryrc.
  #
  require File.dirname(__FILE__) + "/awesome_print/ext/active_record"  if defined?(ActiveRecord)  || AwesomePrint.rails_console?
  require File.dirname(__FILE__) + "/awesome_print/ext/active_support" if defined?(ActiveSupport) || AwesomePrint.rails_console?
  #
  # Load remaining extensions.
  #
  require File.dirname(__FILE__) + "/awesome_print/ext/action_view"    if defined?(ActionView::Base)
  require File.dirname(__FILE__) + "/awesome_print/ext/mongo_mapper"   if defined?(MongoMapper)
  require File.dirname(__FILE__) + "/awesome_print/ext/mongoid"        if defined?(Mongoid)
  require File.dirname(__FILE__) + "/awesome_print/ext/nokogiri"       if defined?(Nokogiri)
end
