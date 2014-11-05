#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Reloads classes
def reload!
  Padrino.reload!
end

# Show applications
def applications
  puts "==== List of Mounted Applications ====\n\n"
  Padrino.mounted_apps.each do |app|
    puts " * %-10s mapped to      %s" % [app.name, app.uri_root]
  end
  puts
  Padrino.mounted_apps.map { |app| "#{app.name} => #{app.uri_root}" }
end

# Load apps
Padrino.mounted_apps.each do |app|
  puts "=> Loading Application #{app.app_class}"
  app.app_obj.setup_application!
end
