#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'active_support/benchmarkable'

module ActionView #:nodoc:
  module Helpers #:nodoc:
    extend ActiveSupport::Autoload

    autoload :ActiveModelHelper
    autoload :AssetTagHelper
    autoload :AtomFeedHelper
    autoload :CacheHelper
    autoload :CaptureHelper
    autoload :ControllerHelper
    autoload :CsrfHelper
    autoload :DateHelper
    autoload :DebugHelper
    autoload :FormHelper
    autoload :FormOptionsHelper
    autoload :FormTagHelper
    autoload :JavaScriptHelper, "action_view/helpers/javascript_helper"
    autoload :NumberHelper
    autoload :OutputSafetyHelper
    autoload :RecordTagHelper
    autoload :RenderingHelper
    autoload :SanitizeHelper
    autoload :TagHelper
    autoload :TextHelper
    autoload :TranslationHelper
    autoload :UrlHelper

    extend ActiveSupport::Concern

    included do
      extend SanitizeHelper::ClassMethods
    end

    include ActiveSupport::Benchmarkable
    include ActiveModelHelper
    include AssetTagHelper
    include AtomFeedHelper
    include CacheHelper
    include CaptureHelper
    include ControllerHelper
    include CsrfHelper
    include DateHelper
    include DebugHelper
    include FormHelper
    include FormOptionsHelper
    include FormTagHelper
    include JavaScriptHelper
    include NumberHelper
    include OutputSafetyHelper
    include RecordTagHelper
    include RenderingHelper
    include SanitizeHelper
    include TagHelper
    include TextHelper
    include TranslationHelper
    include UrlHelper
  end
end
