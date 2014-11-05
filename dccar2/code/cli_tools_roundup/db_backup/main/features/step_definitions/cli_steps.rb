#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
Given /^no configuration file$/ do
  rm_rf @tmp_yaml_config, :secure => true, :verbose => false
  rm_rf @tmp_ruby_config, :secure => true, :verbose => false
end

Given /^a yaml configuration file that specifies that "force" is "true"$/ do
  File.open(@tmp_yaml_config,'w') do |file|
    YAML.dump( { :force => true }, file)
  end
end

Given /^a ruby configuration file that specifies that "force" is "true"$/ do
  File.open(@tmp_ruby_config,'w') do |file|
    file.puts " { :force => true }"
  end
end

Then /^the yaml configuration file should exist with defaults for all options$/ do
  yaml_config = File.open(@tmp_yaml_config) { |file| YAML.load(file) }
  [:username,:password,:gzip,:force,:'end-of-iteration'].each do |key|
    yaml_config.should have_key(key)
  end

  yaml_config[:username].should == nil
  yaml_config[:password].should == nil
  yaml_config[:'end-of-iteration'].should == false
  yaml_config[:gzip].should == true
  yaml_config[:force].should == false
end

Then /^the ruby configuration file should exist with defaults for all options$/ do
  ruby = File.open(@tmp_ruby_config).readlines.join('')
  ruby.should =~ /\{/
  ruby.should =~ /:username\s*=>\s*nil/
  ruby.should =~ /:password\s*=>\s*nil/
  ruby.should =~ /:"end-of-iteration"\s*=>\s*false/
  ruby.should =~ /:gzip\s*=>\s*true/
  ruby.should =~ /:force\s*=>\s*false/
end
