#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class WebServiceGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, "#{class_name}Api", "#{class_name}Controller", "#{class_name}ApiTest"

      # API and test directories.
      m.directory File.join('app/apis', class_path)
      m.directory File.join('app/controllers', class_path)
      m.directory File.join('test/functional', class_path)

      # API definition, controller, and functional test.
      m.template 'api_definition.rb',
                  File.join('app/apis',
                            class_path,
                            "#{file_name}_api.rb")

      m.template 'controller.rb',
                  File.join('app/controllers',
                            class_path,
                            "#{file_name}_controller.rb")

      m.template 'functional_test.rb',
                  File.join('test/functional',
                            class_path,
                            "#{file_name}_api_test.rb")
    end
  end
end
