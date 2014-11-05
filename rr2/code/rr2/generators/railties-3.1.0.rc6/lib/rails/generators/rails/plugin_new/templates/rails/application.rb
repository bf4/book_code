#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.expand_path('../boot', __FILE__)

<% if include_all_railties? -%>
require 'rails/all'
<% else -%>
# Pick the frameworks you want:
<%= comment_if :skip_active_record %> require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
<%= comment_if :skip_sprockets %> require "sprockets/railtie"
<%= comment_if :skip_test_unit %> require "rails/test_unit/railtie"
<% end -%>

Bundler.require
require "<%= name %>"

<%= application_definition %>
