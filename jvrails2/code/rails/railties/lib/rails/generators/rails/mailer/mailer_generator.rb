#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module Rails
  module Generators
    class MailerGenerator < NamedBase
      source_root File.expand_path("../templates", __FILE__)
      argument :actions, type: :array,
        default: [], banner: "method method"
      check_class_collision
      def create_mailer_file
        template "mailer.rb",
          File.join("app/mailers", class_path, "#{file_name}.rb")
      end
      hook_for :template_engine, :test_framework
    end
  end
end
