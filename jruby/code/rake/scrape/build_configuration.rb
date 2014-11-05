#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
configuration do |c|
  c.compile_ruby_files = false
  c.target_jvm_version = 1.5

  # Exclude .java files from the generated .jar file.
  c.source_exclude_filter = Dir['lib/ruby/**/*.java'].map do |file|
    Regexp.new(File.basename(file).gsub(".", "\\.") + "$")
  end
end
