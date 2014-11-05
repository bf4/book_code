$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mongo_metrics/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mongo_metrics"
  s.version     = MongoMetrics::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MongoMetrics."
  s.description = "TODO: Description of MongoMetrics."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "jquery-rails", "~> 3.0.1"
  s.add_dependency "mongoid", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
