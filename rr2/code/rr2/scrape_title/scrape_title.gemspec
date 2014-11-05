# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scrape_title/version"

Gem::Specification.new do |s|
  s.name        = "scrape_title"
  s.version     = ScrapeTitle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chad Fowler"]
  s.email       = ["chad@chadfowler.com"]
  s.homepage    = "http://chadfowler.com"
  s.summary     = %q{Scrapes and prints the title of a given web page}
  s.description = %q{Scrapes and prints the title of a given web page. 
                  Used as an example for the book, Rails Recipes}
  s.add_dependency "httparty", "~> 0.6"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
