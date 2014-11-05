#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'zlib'
require 'pathname'

class GlobalizeGenerator < MigrationGenerator
  def initialize(runtime_args, runtime_options = {})
    arg = runtime_args.first
    @tiny = arg && arg.downcase == 'tiny'
    super([ "globalize_migration" ] + runtime_args, runtime_options)
  end

  def banner
    "Usage: script/generate globalize [tiny]\n" +
    '  Specify "tiny" to generate a compact version of the data files (major languages only).'
  end

  def inflate_schema
    deflated_name = @tiny ? 'tiny_migration.rb.gz' : 'migration.rb.gz'
    inflated_path = source_path('migration.rb')
    deflated_path = source_path(deflated_name)

    return if File.exist?(inflated_path) && !File.exist?(deflated_path)
    return if !File.exist?(deflated_path)

    File.open(inflated_path, 'w') do |f|
      Zlib::GzipReader.open(deflated_path) do |gzip|
        gzip.each do |line|
          line.chomp!
          f.puts line
        end
      end
    end
  end

  def manifest
    record do |m|
      m.directory 'db/migrate'
      m.inflate_schema
      m.migration_template 'migration.rb', 'db/migrate'
    end
  end
end

