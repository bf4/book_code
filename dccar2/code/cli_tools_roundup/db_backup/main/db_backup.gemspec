$:.push File.expand_path("../lib", __FILE__)

require "db_backup/version"

Gem::Specification.new do |s|
  s.name        = "db_backup"
  s.version     = DbBackup::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Bryant Copeland"]
  s.email       = ["davec@naildrivin5.com"]
  s.homepage    = "http://www.davetron5000.com"
  s.summary     = %q{a simple MySQL backup app}
  s.description = %q{a simple MySQL backup app}

  s.rubyforge_project = "db_backup"

  s.files         = %w(
    bin/db_backup.rb
    lib/db_backup/version.rb
    man/db_backup.1
  )
  s.executables   = ['db_backup.rb']
  s.add_development_dependency('aruba', '~> 0.3.6')
  s.add_dependency('main')
end
