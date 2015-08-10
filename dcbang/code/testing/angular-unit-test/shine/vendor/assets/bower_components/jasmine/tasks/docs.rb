#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
desc "Build jasmine documentation"
task :doc => :require_pages_submodule do
  puts 'Creating Jasmine Documentation'
  require 'rubygems'
  require 'jsdoc_helper'

  FileUtils.rm_r "pages/jsdoc", :force => true

  JsdocHelper::Rake::Task.new(:lambda_jsdoc) do |t|
    t[:files] = core_sources + html_sources + console_sources
    t[:options] = "-a"
    t[:out] = "pages/jsdoc"
    # JsdocHelper bug: template must be relative to the JsdocHelper gem, ick
    t[:template] = File.join("../".*(100), Dir::getwd, "jsdoc-template")
  end
  Rake::Task[:lambda_jsdoc].invoke
end
