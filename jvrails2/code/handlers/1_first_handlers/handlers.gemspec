$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "handlers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "handlers"
  s.version     = Handlers::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Handlers."
  s.description = "TODO: Description of Handlers."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "rdiscount", "~> 2.0.0"

  s.add_development_dependency "sqlite3"
end
