#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
activesupport_path = File.expand_path('../../../activesupport/lib', __FILE__)
$:.unshift(activesupport_path) if File.directory?(activesupport_path) && !$:.include?(activesupport_path)

require 'action_pack'
require 'active_support/concern'
require 'active_support/ruby/shim'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/module/attr_internal'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/anonymous'
require 'active_support/i18n'

module AbstractController
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Callbacks
  autoload :Collector
  autoload :Helpers
  autoload :Layouts
  autoload :Logger
  autoload :Rendering
  autoload :Translation
  autoload :AssetPaths
  autoload :ViewPaths
  autoload :UrlFor
end
