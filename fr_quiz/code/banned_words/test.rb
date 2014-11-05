#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require 'test_harness'
require 'optimized'

configs = []

# words,banned,tests,change banned words every test
configs << RQ9TestRunConfiguration.new(3000,3,10,true)
configs << RQ9TestRunConfiguration.new(3000,80,10,true)
configs << RQ9TestRunConfiguration.new(3000,300,10,true)

algorithm_test = RQ9AlgorithmTest.new
algorithm_test.read_word_list("/usr/share/dict/words")

configs.each do |config|
    puts "Test: #{config.to_s}"
    puts algorithm_test.test_algorithm(config,YourAlgorithm.new).ext_to_s # to_s
end
