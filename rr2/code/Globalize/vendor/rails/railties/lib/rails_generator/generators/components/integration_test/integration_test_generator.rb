#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class IntegrationTestGenerator < Rails::Generator::NamedBase
  default_options :skip_migration => false

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, class_name, "#{class_name}Test"

      # integration test directory
      m.directory File.join('test/integration', class_path)

      # integration test stub
      m.template 'integration_test.rb', File.join('test/integration', class_path, "#{file_name}_test.rb")
    end
  end
end
