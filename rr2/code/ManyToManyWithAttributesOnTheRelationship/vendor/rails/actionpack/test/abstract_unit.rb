#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/../../activesupport/lib/active_support')
$:.unshift(File.dirname(__FILE__) + '/fixtures/helpers')

require 'yaml'
require 'test/unit'
require 'action_controller'
require 'breakpoint'

require 'action_controller/test_process'

ActionController::Base.logger = nil
ActionController::Base.ignore_missing_templates = false
ActionController::Routing::Routes.reload rescue nil