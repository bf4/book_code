#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "action_view/template"
require "handlers/railtie"

ActionView::Template.register_template_handler :rb,
  lambda { |template| template.source }

ActionView::Template.register_template_handler :rb, :source.to_proc

ActionView::Template.register_template_handler :string,
  lambda { |template| "%Q{#{template.source}}" }


require "rdiscount"
ActionView::Template.register_template_handler :md,
  lambda { |template| "RDiscount.new(#{template.source.inspect}).to_html" }

module Handlers
  module MERB
    def self.erb_handler
      @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def self.call(template)
      compiled_source = erb_handler.call(template)
      if template.formats.include?(:html)
        "RDiscount.new(begin;#{compiled_source};end).to_html"
      else
        compiled_source
      end
    end
  end
end

ActionView::Template.register_template_handler :merb, Handlers::MERB
