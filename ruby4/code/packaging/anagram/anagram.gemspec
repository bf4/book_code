Gem::Specification.new do |s| 
  s.name         = "anagram"
  s.summary      = "Find anagrams of words supplied on the command line"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.requirements = 
      [ 'An installed dictionary (most Unix systems have one)' ]
  s.version     = "0.0.1"
  s.author      = "Dave Thomas"
  s.email       = "dave@pragprog.com"
  s.homepage    = "http://pragdave.pragprog.com"
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.9'
  s.files       = Dir['**/**']
  s.executables = [ 'anagram' ]
  s.test_files  = Dir["test/test*.rb"]
  s.has_rdoc    = false
end
