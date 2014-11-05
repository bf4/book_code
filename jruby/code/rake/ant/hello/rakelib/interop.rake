require 'ant'

ant_import

task :goodbye_from_rake => :hello_from_ant do
  puts 'Goodbye from Rake!'
end
