#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class TumblepostGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  check_class_collision
  desc "Generator tumblelog post types and supporting files"

  def manifest
    template "app/controllers/controller_template.rb",
             "app/controllers/#{file_name}_controller.rb"
    template "app/models/model_template.rb",
             "app/models/#{file_name}.rb"
    template "app/views/form_template.html.erb",
             "app/views/#{file_name}/_form.html.erb"
    template "app/views/view_template.html.erb",
             "app/views/#{file_name}/_view.html.erb"
    readme "POST_GENERATION_REMINDER"
  end
end
