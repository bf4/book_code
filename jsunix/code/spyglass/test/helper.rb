#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
require 'bundler/setup'
require 'minitest/autorun'

class MiniTest::Unit::TestCase
  ROOT = File.dirname(__FILE__) + '/..'
  TEST_CONFIG_RU = File.open("#{ROOT}/test/config.ru", 'r+')
  PORT = 5656
  LOG = File.join('test', 'log', 'spyglass.log')
  warn "Spyglass output can be found in #{LOG}"
  
  def spyglass(args = {})
    string_args = args.map { |key, value| "--#{key}=#{value}" }
    config_ru = @ad_hoc_config_ru || TEST_CONFIG_RU
    
    cmd = "ruby -I\"#{ROOT}/lib\" -rubygems \"#{ROOT}/bin/spyglass\" --vverbose -c \"#{config_ru.path}\" -p#{PORT} #{string_args.join(' ')}"
    @pid = Process.spawn(cmd, :err => :out, :out => LOG)
    sleep 1.5
  end
  
  def config_ru(content)
    # This ensures that we have a unique filename for each test run
    filename = File.join(ROOT, 'test', Digest::MD5.hexdigest($PROGRAM_NAME) + 'config.ru')
    @ad_hoc_config_ru = File.open(filename, 'w')
    @ad_hoc_config_ru.write content
    @ad_hoc_config_ru.flush
  end
  
  def teardown
    @pid && Process.kill(:QUIT, @pid)
    @ad_hoc_config_ru && File.unlink(@ad_hoc_config_ru.path)
  rescue Errno::ESRCH
  end
end
