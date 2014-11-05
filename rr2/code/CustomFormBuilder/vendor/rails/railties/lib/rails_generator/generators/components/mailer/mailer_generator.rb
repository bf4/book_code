#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class MailerGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, class_name, "#{class_name}Test"

      # Mailer, view, test, and fixture directories.
      m.directory File.join('app/models', class_path)
      m.directory File.join('app/views', class_path, file_name)
      m.directory File.join('test/unit', class_path)
      m.directory File.join('test/fixtures', class_path, file_name)

      # Mailer class and unit test.
      m.template "mailer.rb",    File.join('app/models',
                                           class_path,
                                           "#{file_name}.rb")
      m.template "unit_test.rb", File.join('test/unit',
                                           class_path,
                                           "#{file_name}_test.rb")

      # View template and fixture for each action.
      actions.each do |action|
        m.template "view.rhtml",
                   File.join('app/views', class_path, file_name, "#{action}.rhtml"),
                   :assigns => { :action => action }
        m.template "fixture.rhtml",
                   File.join('test/fixtures', class_path, file_name, action),
                   :assigns => { :action => action }
      end
    end
  end
end
